import Capacitor
import CryptoKit
import Foundation
import SQLite3
import UIKit

private struct SignedManifest: Decodable {
    let payload: String
    let signature: String
}

private struct UpdateManifest: Decodable {
    let datasetVersion: String
    let schemaVersion: Int
    let contractVersion: Int
    let minAppBuild: Int
    let url: URL
    let size: Int
    let sha256: String
}

@objc(EraLensNativePlugin)
public class EraLensNativePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "EraLensNativePlugin"
    public let jsName = "EraLensNative"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "getContentInfo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "prepareContentDatabase", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "checkForUpdate", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "installPendingUpdate", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "openExternal", returnType: CAPPluginReturnPromise),
    ]

    private let databaseName = "eralens-contentSQLite.db"
    private let candidateName = "eralens-content.candidate.db"
    private let previousName = "eralens-content.previous.db"
    private let expectedSchemaVersion = 5
    private let expectedContractVersion = 7

    @objc public func getContentInfo(_ call: CAPPluginCall) {
        do {
            let metadata = try readMetadata(at: databaseURL)
            call.resolve([
                "datasetVersion": metadata["dataset_version"] ?? "unknown",
                "schemaVersion": Int(metadata["schema_version"] ?? "0") ?? 0,
                "contractVersion": Int(metadata["contract_version"] ?? "0") ?? 0,
                "sourceGitSha": metadata["source_git_sha"] ?? "unknown",
                "builtAt": metadata["built_at"] ?? "unknown",
                "configured": manifestURL != nil && publicKey != nil
            ])
        } catch {
            call.reject("无法读取本地数据版本：\(error.localizedDescription)")
        }
    }

    @objc public func prepareContentDatabase(_ call: CAPPluginCall) {
        do {
            try installBundledBaselineIfNewer()
            do {
                let metadata = try validateDatabase(at: databaseURL)
                call.resolve(["datasetVersion": metadata["dataset_version"] ?? "unknown", "recovered": false])
            } catch {
                let previous = documentsURL.appendingPathComponent(previousName)
                let restoreFrom: URL
                if FileManager.default.fileExists(atPath: previous.path), (try? validateDatabase(at: previous)) != nil {
                    restoreFrom = previous
                } else if let baseline = bundledDatabaseURL, (try? validateDatabase(at: baseline)) != nil {
                    restoreFrom = baseline
                } else {
                    throw error
                }
                try replaceDatabase(with: restoreFrom)
                let restored = try validateDatabase(at: databaseURL)
                call.resolve(["datasetVersion": restored["dataset_version"] ?? "unknown", "recovered": true])
            }
        } catch {
            call.reject("本地数据校验失败，且没有可恢复的上一版本：\(error.localizedDescription)")
        }
    }

    @objc public func checkForUpdate(_ call: CAPPluginCall) {
        guard let manifestURL, let publicKey else {
            call.resolve(["configured": false, "available": false, "message": "尚未配置数据更新服务。当前离线数据仍可使用。"])
            return
        }
        Task {
            do {
                let current = try readMetadata(at: databaseURL)
                let (manifestData, manifestResponse) = try await URLSession.shared.data(from: manifestURL)
                guard manifestResponse.url?.scheme == "https",
                      let manifestHTTP = manifestResponse as? HTTPURLResponse,
                      (200..<300).contains(manifestHTTP.statusCode), manifestData.count <= 64 * 1024 else {
                    throw UpdateError.download("数据清单请求失败或响应过大")
                }
                let envelope = try JSONDecoder().decode(SignedManifest.self, from: manifestData)
                guard let payload = Data(base64Encoded: envelope.payload),
                      let signature = Data(base64Encoded: envelope.signature),
                      let keyData = Data(base64Encoded: publicKey) else {
                    throw UpdateError.invalidManifest("签名字段格式无效")
                }
                let key = try Curve25519.Signing.PublicKey(rawRepresentation: keyData)
                guard key.isValidSignature(signature, for: payload) else {
                    throw UpdateError.invalidManifest("数据清单签名校验失败")
                }
                let manifest = try JSONDecoder().decode(UpdateManifest.self, from: payload)
                try validateCompatibility(manifest)
                if current["dataset_version"] == manifest.datasetVersion {
                    call.resolve(["configured": true, "available": false, "message": "当前已是最新数据（\(manifest.datasetVersion)）。"])
                    return
                }
                guard isVersion(manifest.datasetVersion, newerThan: current["dataset_version"] ?? "0") else {
                    throw UpdateError.incompatible("拒绝安装早于当前版本的数据包")
                }
                guard manifest.size > 0, manifest.size <= 100 * 1024 * 1024,
                      manifest.url.scheme == "https" else {
                    throw UpdateError.invalidManifest("下载地址或文件大小不符合要求")
                }
                let (temporaryURL, response) = try await URLSession.shared.download(from: manifest.url)
                if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
                    throw UpdateError.download("服务器返回 HTTP \(response.statusCode)")
                }
                if response.url?.scheme != "https" { throw UpdateError.download("下载重定向必须保持 HTTPS") }
                guard response.url?.scheme == "https",
                      let downloadHTTP = response as? HTTPURLResponse,
                      (200..<300).contains(downloadHTTP.statusCode) else {
                    throw UpdateError.download("数据文件请求失败")
                }
                let actualHash = try sha256File(temporaryURL)
                let actualSize = ((try? FileManager.default.attributesOfItem(atPath: temporaryURL.path)[.size]) as? NSNumber)?.intValue ?? -1
                guard actualSize == manifest.size else { throw UpdateError.download("下载文件大小与清单不符") }
                guard actualHash.caseInsensitiveCompare(manifest.sha256) == .orderedSame else {
                    throw UpdateError.invalidManifest("数据文件 SHA-256 校验失败")
                }
                let candidate = documentsURL.appendingPathComponent(candidateName)
                try? FileManager.default.removeItem(at: candidate)
                try FileManager.default.copyItem(at: temporaryURL, to: candidate)
                let candidateMetadata = try validateDatabase(at: candidate)
                guard candidateMetadata["dataset_version"] == manifest.datasetVersion else {
                    try? FileManager.default.removeItem(at: candidate)
                    throw UpdateError.invalidDatabase("版本号与清单不一致")
                }
                UserDefaults.standard.set(actualHash.lowercased(), forKey: "pendingMobileDataSha256")
                call.resolve(["configured": true, "available": true, "datasetVersion": manifest.datasetVersion, "message": "已下载并校验数据版本 \(manifest.datasetVersion)。"])
            } catch {
                call.reject("检查数据更新失败，仍使用当前数据：\(error.localizedDescription)")
            }
        }
    }

    @objc public func installPendingUpdate(_ call: CAPPluginCall) {
        do {
            let candidate = documentsURL.appendingPathComponent(candidateName)
            let metadata = try validateDatabase(at: candidate)
            guard let expectedHash = UserDefaults.standard.string(forKey: "pendingMobileDataSha256"),
                  try sha256File(candidate).caseInsensitiveCompare(expectedHash) == .orderedSame else {
                throw UpdateError.invalidDatabase("候选数据已变化或未经过签名校验")
            }
            let current = databaseURL
            let previous = documentsURL.appendingPathComponent(previousName)
            let manager = FileManager.default
            if manager.fileExists(atPath: current.path) {
                try? manager.removeItem(at: previous)
                try manager.copyItem(at: current, to: previous)
                do {
                    _ = try manager.replaceItemAt(current, withItemAt: candidate)
                } catch {
                    try? manager.removeItem(at: current)
                    try manager.copyItem(at: previous, to: current)
                    throw error
                }
            } else {
                try manager.moveItem(at: candidate, to: current)
            }
            UserDefaults.standard.removeObject(forKey: "pendingMobileDataSha256")
            call.resolve([
                "datasetVersion": metadata["dataset_version"] ?? "unknown",
                "message": "数据已更新。"
            ])
        } catch {
            call.reject("更新未安装，仍保留上一份可用数据：\(error.localizedDescription)")
        }
    }

    @objc public func openExternal(_ call: CAPPluginCall) {
        guard let raw = call.getString("url"), let url = URL(string: raw),
              ["https", "http"].contains(url.scheme?.lowercased() ?? ""),
              let host = url.host, !host.isEmpty else {
            call.reject("只允许打开有效的 HTTP/HTTPS 来源链接")
            return
        }
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:]) { success in
                if success { call.resolve() } else { call.reject("无法打开来源链接") }
            }
        }
    }

    private var manifestURL: URL? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "ERA_DATA_MANIFEST_URL") as? String,
              let url = URL(string: value), url.scheme == "https", url.host != nil else { return nil }
        return url
    }

    private var publicKey: String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "ERA_DATA_PUBLIC_KEY") as? String,
              Data(base64Encoded: value)?.count == 32 else { return nil }
        return value
    }

    private var documentsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    private var databaseURL: URL { documentsURL.appendingPathComponent(databaseName) }

    private var bundledDatabaseURL: URL? {
        guard let resources = Bundle.main.resourceURL else { return nil }
        let file = resources.appendingPathComponent("public/assets/databases/eralens-content.db")
        return FileManager.default.fileExists(atPath: file.path) ? file : nil
    }

    private func installBundledBaselineIfNewer() throws {
        guard let baseline = bundledDatabaseURL,
              FileManager.default.fileExists(atPath: databaseURL.path),
              let current = try? validateDatabase(at: databaseURL),
              let packaged = try? validateDatabase(at: baseline),
              let currentVersion = current["dataset_version"],
              let packagedVersion = packaged["dataset_version"],
              isVersion(packagedVersion, newerThan: currentVersion) else { return }
        try? FileManager.default.removeItem(at: documentsURL.appendingPathComponent(previousName))
        try FileManager.default.copyItem(at: databaseURL, to: documentsURL.appendingPathComponent(previousName))
        try replaceDatabase(with: baseline)
    }

    private func replaceDatabase(with source: URL) throws {
        let manager = FileManager.default
        let replacement = documentsURL.appendingPathComponent("eralens-content.replacement.db")
        try? manager.removeItem(at: replacement)
        try manager.copyItem(at: source, to: replacement)
        if manager.fileExists(atPath: databaseURL.path) {
            _ = try manager.replaceItemAt(databaseURL, withItemAt: replacement)
        } else {
            try manager.moveItem(at: replacement, to: databaseURL)
        }
    }

    private func isVersion(_ candidate: String, newerThan current: String) -> Bool {
        let left = candidate.split(separator: ".").map { Int($0) ?? 0 }
        let right = current.split(separator: ".").map { Int($0) ?? 0 }
        for index in 0..<max(left.count, right.count) {
            let a = index < left.count ? left[index] : 0
            let b = index < right.count ? right[index] : 0
            if a != b { return a > b }
        }
        return false
    }

    private func validateCompatibility(_ manifest: UpdateManifest) throws {
        guard manifest.schemaVersion == expectedSchemaVersion,
              manifest.contractVersion == expectedContractVersion else {
            throw UpdateError.incompatible("数据 schema/contract 与此应用不兼容")
        }
        let appBuild = Int(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0") ?? 0
        guard manifest.minAppBuild <= appBuild else {
            throw UpdateError.incompatible("需要更新应用后才能安装此数据版本")
        }
    }

    private func readMetadata(at url: URL) throws -> [String: String] {
        guard FileManager.default.fileExists(atPath: url.path) else { throw UpdateError.invalidDatabase("本地数据库不存在") }
        return try validateDatabase(at: url)
    }

    private func validateDatabase(at url: URL) throws -> [String: String] {
        guard FileManager.default.fileExists(atPath: url.path) else { throw UpdateError.invalidDatabase("数据库文件不存在") }
        var db: OpaquePointer?
        guard sqlite3_open_v2(url.path, &db, SQLITE_OPEN_READONLY, nil) == SQLITE_OK, let db else {
            throw UpdateError.invalidDatabase("无法打开 SQLite 数据库")
        }
        defer { sqlite3_close(db) }
        guard try queryText(db, "PRAGMA integrity_check") == "ok" else { throw UpdateError.invalidDatabase("SQLite integrity_check 未通过") }
        guard try queryText(db, "PRAGMA foreign_key_check") == nil else { throw UpdateError.invalidDatabase("SQLite foreign_key_check 未通过") }
        let metadata = try queryMetadata(db)
        guard Int(metadata["schema_version"] ?? "0") == expectedSchemaVersion,
              Int(metadata["contract_version"] ?? "0") == expectedContractVersion else {
            throw UpdateError.incompatible("数据库 schema/contract 版本不受支持")
        }
        return metadata
    }

    private func queryMetadata(_ db: OpaquePointer) throws -> [String: String] {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, "SELECT key, value FROM content_metadata", -1, &statement, nil) == SQLITE_OK, let statement else {
            throw UpdateError.invalidDatabase("缺少 content_metadata")
        }
        defer { sqlite3_finalize(statement) }
        var result: [String: String] = [:]
        while sqlite3_step(statement) == SQLITE_ROW {
            if let key = sqlite3_column_text(statement, 0), let value = sqlite3_column_text(statement, 1) {
                let raw = String(cString: value)
                if let data = raw.data(using: .utf8),
                   let parsed = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) {
                    result[String(cString: key)] = String(describing: parsed)
                } else {
                    result[String(cString: key)] = raw
                }
            }
        }
        return result
    }

    private func sha256File(_ url: URL) throws -> String {
        let handle = try FileHandle(forReadingFrom: url)
        defer { try? handle.close() }
        var hasher = SHA256()
        while let chunk = try handle.read(upToCount: 1024 * 1024), !chunk.isEmpty {
            hasher.update(data: chunk)
        }
        return hasher.finalize().map { String(format: "%02x", $0) }.joined()
    }

    private func queryText(_ db: OpaquePointer, _ sql: String) throws -> String? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK, let statement else {
            throw UpdateError.invalidDatabase("SQLite 校验查询失败")
        }
        defer { sqlite3_finalize(statement) }
        guard sqlite3_step(statement) == SQLITE_ROW else { return nil }
        guard let value = sqlite3_column_text(statement, 0) else { return nil }
        return String(cString: value)
    }
}

private enum UpdateError: LocalizedError {
    case invalidManifest(String), incompatible(String), download(String), invalidDatabase(String)
    var errorDescription: String? {
        switch self {
        case .invalidManifest(let message), .incompatible(let message), .download(let message), .invalidDatabase(let message): return message
        }
    }
}

class EraLensBridgeViewController: CAPBridgeViewController {
    override func capacitorDidLoad() {
        super.capacitorDidLoad()
        bridge?.registerPluginInstance(EraLensNativePlugin())
    }
}
