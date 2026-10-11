import CoreFoundation
import Foundation
@preconcurrency import WebKit
import SQLite3

public enum EraLensPlatform: String {
    case ios
    case mac
}

public enum EraLensNativeError: LocalizedError {
    case invalidRequest
    case resourceNotFound
    case database(String)

    public var errorDescription: String? {
        switch self {
        case .invalidRequest: "原生桥接请求无效"
        case .resourceNotFound: "应用资源不存在或无法读取"
        case .database(let message): message
        }
    }
}

public enum EraLensContentVersion {
    public static func validate(metadata: [String: String], schemaVersion: Int, contractVersion: Int) throws {
        guard Int(metadata["schema_version"] ?? "") == schemaVersion,
              Int(metadata["contract_version"] ?? "") == contractVersion else {
            throw EraLensNativeError.database("应用附带的 SQLite 数据版本与当前界面不兼容")
        }
    }
}

public final class EraLensSettingsStore {
    private let defaults: UserDefaults
    private let namespace: String

    public init(defaults: UserDefaults = .standard, namespace: String = "eralens.setting.") {
        self.defaults = defaults
        self.namespace = namespace
    }

    public func get(_ key: String) -> String? { defaults.string(forKey: namespace + key) }
    public func set(_ value: String, for key: String) { defaults.set(value, forKey: namespace + key) }
}

public final class EraLensResourceSchemeHandler: NSObject, WKURLSchemeHandler {
    private let root: URL
    private let queue = DispatchQueue(label: "com.eralens.native.resources", qos: .userInitiated)
    private let lock = NSLock()
    private var tasks: [ObjectIdentifier: DispatchWorkItem] = [:]

    public init(root: URL) {
        self.root = root.standardizedFileURL.resolvingSymlinksInPath()
        super.init()
    }

    public func resourceURL(for url: URL) -> URL? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              components.scheme == "eralens", components.host == "app",
              components.user == nil, components.password == nil, components.port == nil,
              components.query == nil, components.fragment == nil else { return nil }
        let path = components.path == "/" ? "/index.html" : components.path
        guard !path.contains("\\"), !path.split(separator: "/").contains("..") else { return nil }
        let candidate = root.appending(path: String(path.dropFirst())).standardizedFileURL.resolvingSymlinksInPath()
        guard candidate.path.hasPrefix(root.path + "/"), FileManager.default.fileExists(atPath: candidate.path) else { return nil }
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: candidate.path, isDirectory: &isDirectory), !isDirectory.boolValue else { return nil }
        return candidate
    }

    public func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        let key = ObjectIdentifier(urlSchemeTask as AnyObject)
        let item = DispatchWorkItem { [weak self] in
            guard let self else { return }
            guard let requestURL = urlSchemeTask.request.url,
                  let file = self.resourceURL(for: requestURL), let data = try? Data(contentsOf: file) else {
                DispatchQueue.main.async {
                    guard !self.isTaskCancelled(key) else { self.removeTask(key); return }
                    urlSchemeTask.didFailWithError(EraLensNativeError.resourceNotFound)
                    self.removeTask(key)
                }
                return
            }
            let mime = Self.mimeType(for: file.pathExtension)
            let response = HTTPURLResponse(
                url: requestURL,
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: [
                    "Content-Type": mime + (mime.hasPrefix("text/") || mime == "application/javascript" ? "; charset=utf-8" : ""),
                    "Content-Length": String(data.count),
                    "Access-Control-Allow-Origin": "*",
                ]
            )!
            DispatchQueue.main.async {
                guard !self.isTaskCancelled(key) else { self.removeTask(key); return }
                urlSchemeTask.didReceive(response)
                urlSchemeTask.didReceive(data)
                urlSchemeTask.didFinish()
                self.removeTask(key)
            }
        }
        lock.lock()
        tasks[key] = item
        lock.unlock()
        queue.async(execute: item)
    }

    public func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        let key = ObjectIdentifier(urlSchemeTask as AnyObject)
        lock.lock()
        let item = tasks.removeValue(forKey: key)
        lock.unlock()
        item?.cancel()
    }

    public static func mimeType(for ext: String) -> String {
        switch ext.lowercased() {
        case "html": "text/html"
        case "js", "mjs": "application/javascript"
        case "css": "text/css"
        case "json", "map": "application/json"
        case "svg": "image/svg+xml"
        case "png": "image/png"
        case "jpg", "jpeg": "image/jpeg"
        case "woff": "font/woff"
        case "woff2": "font/woff2"
        case "ttf": "font/ttf"
        case "ico": "image/x-icon"
        default: "application/octet-stream"
        }
    }

    private func removeTask(_ key: ObjectIdentifier) {
        lock.lock()
        tasks.removeValue(forKey: key)
        lock.unlock()
    }
}

extension EraLensResourceSchemeHandler {
    fileprivate func isTaskCancelled(_ key: ObjectIdentifier) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return tasks[key]?.isCancelled ?? true
    }
}

public final class EraLensReadOnlyDatabase {
    private let url: URL
    private let queue: DispatchQueue
    private var handle: OpaquePointer?

    public init(url: URL, queueLabel: String = "com.eralens.native.sqlite") {
        self.url = url
        queue = DispatchQueue(label: queueLabel, qos: .userInitiated)
    }

    public func query(_ sql: String, _ values: [Any], completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        queue.async {
            do { completion(.success(try self.querySynchronously(sql, values))) }
            catch { completion(.failure(error)) }
        }
    }

    public func close(completion: @escaping (Error?) -> Void) {
        queue.async {
            guard let db = self.handle else { completion(nil); return }
            let status = sqlite3_close(db)
            guard status == SQLITE_OK else { completion(self.failure(db, status)); return }
            self.handle = nil
            completion(nil)
        }
    }

    func querySynchronously(_ sql: String, _ values: [Any]) throws -> [[String: Any]] {
        guard let first = sql.trimmingCharacters(in: .whitespacesAndNewlines).split(whereSeparator: \.isWhitespace).first,
              first.uppercased() == "SELECT" || first.uppercased() == "WITH" else {
            throw EraLensNativeError.database("仅允许 SELECT 查询")
        }
        let db = try connection()
        var statement: OpaquePointer?
        var tailHasNoAdditionalStatements = false
        let status = sql.withCString { pointer in
            var tail: UnsafePointer<CChar>?
            let result = sqlite3_prepare_v2(db, pointer, -1, &statement, &tail)
            tailHasNoAdditionalStatements = Self.hasNoAdditionalStatements(tail)
            return result
        }
        guard status == SQLITE_OK, let statement else { throw failure(db, status) }
        defer { sqlite3_finalize(statement) }
        guard sqlite3_stmt_readonly(statement) == 1 else { throw EraLensNativeError.database("SQLite 查询仅允许只读语句") }
        guard tailHasNoAdditionalStatements, sqlite3_bind_parameter_count(statement) == values.count else {
            throw EraLensNativeError.database("SQLite 查询参数数量不匹配或包含多条语句")
        }
        for (index, value) in values.enumerated() { try Self.bind(value, to: statement, index: Int32(index + 1), db: db) }
        var rows: [[String: Any]] = []
        while true {
            let result = sqlite3_step(statement)
            if result == SQLITE_DONE { break }
            guard result == SQLITE_ROW else { throw failure(db, result) }
            var row: [String: Any] = [:]
            for column in 0..<sqlite3_column_count(statement) {
                let name = String(cString: sqlite3_column_name(statement, column))
                switch sqlite3_column_type(statement, column) {
                case SQLITE_INTEGER: row[name] = NSNumber(value: sqlite3_column_int64(statement, column))
                case SQLITE_FLOAT: row[name] = NSNumber(value: sqlite3_column_double(statement, column))
                case SQLITE_TEXT: row[name] = String(cString: sqlite3_column_text(statement, column))
                case SQLITE_BLOB:
                    let count = Int(sqlite3_column_bytes(statement, column))
                    if count == 0 { row[name] = "" }
                    else if let blob = sqlite3_column_blob(statement, column) { row[name] = Data(bytes: blob, count: count).base64EncodedString() }
                    else { row[name] = "" }
                default: row[name] = NSNull()
                }
            }
            rows.append(row)
        }
        return rows
    }

    static func hasNoAdditionalStatements(_ tail: UnsafePointer<CChar>?) -> Bool {
        guard let tail else { return true }
        return String(cString: tail).allSatisfy { $0.isWhitespace || $0 == ";" }
    }

    private func connection() throws -> OpaquePointer {
        if let handle { return handle }
        var db: OpaquePointer?
        let status = sqlite3_open_v2(url.path, &db, SQLITE_OPEN_READONLY | SQLITE_OPEN_NOMUTEX, nil)
        guard status == SQLITE_OK, let db else { throw failure(db, status) }
        handle = db
        return db
    }

    private func failure(_ db: OpaquePointer?, _ status: Int32) -> EraLensNativeError {
        EraLensNativeError.database(db.map { String(cString: sqlite3_errmsg($0)) } ?? "SQLite 打开失败（\(status)）")
    }

    private static func bind(_ value: Any, to statement: OpaquePointer, index: Int32, db: OpaquePointer) throws {
        let status: Int32
        if value is NSNull { status = sqlite3_bind_null(statement, index) }
        else if let number = value as? NSNumber, CFGetTypeID(number) == CFBooleanGetTypeID() { status = sqlite3_bind_int(statement, index, number.boolValue ? 1 : 0) }
        else if let number = value as? NSNumber { status = sqlite3_bind_double(statement, index, number.doubleValue) }
        else if let string = value as? String { status = string.withCString { sqlite3_bind_text(statement, index, $0, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self)) } }
        else { throw EraLensNativeError.invalidRequest }
        guard status == SQLITE_OK else { throw EraLensNativeError.database(String(cString: sqlite3_errmsg(db))) }
    }
}

public final class EraLensWebBridge: NSObject, WKScriptMessageHandlerWithReply, WKNavigationDelegate, WKUIDelegate {
    public static let protocolVersion = 1
    public let bootstrap: String

    private let platform: EraLensPlatform
    private let database: EraLensReadOnlyDatabase
    private let versionsURL: URL
    private let openExternalURL: (URL) -> Void
    private let settings = EraLensSettingsStore()

    public init(platform: EraLensPlatform, resourcesURL: URL, openExternal: @escaping (URL) -> Void) {
        self.platform = platform
        database = EraLensReadOnlyDatabase(url: resourcesURL.appendingPathComponent("Content/eralens-content.sqlite"), queueLabel: "com.eralens.\(platform.rawValue).sqlite")
        versionsURL = resourcesURL.appendingPathComponent("Content/versions.json")
        openExternalURL = openExternal
        bootstrap = """
        (() => {
          const handler = window.webkit.messageHandlers.eralensNative;
          const call = (method, args = {}) => handler.postMessage({ method, ...args });
          Object.defineProperty(window, 'eralensNative', { value: Object.freeze({
            platform: '\(platform.rawValue)', protocolVersion: \(Self.protocolVersion),
            query: (sql, values = []) => call('query', { sql, values }),
            closeDatabase: () => call('closeDatabase'),
            getSetting: (key) => call('getSetting', { key }),
            setSetting: (key, value) => call('setSetting', { key, value }),
            getContentInfo: () => call('getContentInfo'),
            openExternal: ({ url }) => call('openExternal', { url }),
          }), writable: false, configurable: false });
        })();
        """
        super.init()
    }

    public func userContentController(_ controller: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        guard Self.allowsBridgeRequest(isMainFrame: message.frameInfo.isMainFrame, origin: message.frameInfo.securityOrigin),
              let body = message.body as? [String: Any], let method = body["method"] as? String else {
            replyHandler(nil, "拒绝非应用页面请求")
            return
        }
        switch method {
        case "query":
            guard let sql = body["sql"] as? String, let values = body["values"] as? [Any] else { replyHandler(nil, EraLensNativeError.invalidRequest.localizedDescription); return }
            database.query(sql, values) { result in
                switch result {
                case .success(let rows): Self.replyOnMain(replyHandler, value: ["values": rows], error: nil)
                case .failure(let error): Self.replyOnMain(replyHandler, value: nil, error: error.localizedDescription)
                }
            }
        case "closeDatabase":
            database.close { error in
                if let error { Self.replyOnMain(replyHandler, value: nil, error: error.localizedDescription) }
                else { Self.replyOnMain(replyHandler, value: NSNull(), error: nil) }
            }
        case "getSetting":
            guard let key = body["key"] as? String else { replyHandler(nil, EraLensNativeError.invalidRequest.localizedDescription); return }
            replyHandler(settings.get(key) ?? NSNull() as Any, nil)
        case "setSetting":
            guard let key = body["key"] as? String, let value = body["value"] as? String else { replyHandler(nil, EraLensNativeError.invalidRequest.localizedDescription); return }
            settings.set(value, for: key)
            replyHandler(NSNull(), nil)
        case "getContentInfo":
            getContentInfo { result in
                switch result {
                case .success(let info): Self.replyOnMain(replyHandler, value: info, error: nil)
                case .failure(let error): Self.replyOnMain(replyHandler, value: nil, error: error.localizedDescription)
                }
            }
        case "openExternal":
            guard let raw = body["url"] as? String, let url = URL(string: raw),
                  ["http", "https"].contains(url.scheme?.lowercased() ?? ""), url.host != nil else {
                replyHandler(nil, EraLensNativeError.invalidRequest.localizedDescription)
                return
            }
            openExternalURL(url)
            replyHandler(NSNull(), nil)
        default:
            replyHandler(nil, EraLensNativeError.invalidRequest.localizedDescription)
        }
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.targetFrame?.isMainFrame != false else { decisionHandler(.cancel); return }
        guard let url = navigationAction.request.url else { decisionHandler(.cancel); return }
        if Self.isAppOrigin(url) { decisionHandler(.allow) }
        else {
            if ["https", "http"].contains(url.scheme?.lowercased() ?? "") { openExternalURL(url) }
            decisionHandler(.cancel)
        }
    }

    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let url = navigationAction.request.url, ["https", "http"].contains(url.scheme?.lowercased() ?? "") { openExternalURL(url) }
        return nil
    }

    private func getContentInfo(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        database.query("SELECT key, value FROM content_metadata", []) { result in
            do {
                let rows = try result.get()
                guard let versionsData = try? Data(contentsOf: self.versionsURL),
                      let versions = try JSONSerialization.jsonObject(with: versionsData) as? [String: Int],
                      let expectedSchema = versions["schemaVersion"], let expectedContract = versions["contractVersion"] else {
                    throw EraLensNativeError.database("应用缺少有效的数据版本配置")
                }
                var metadata: [String: String] = [:]
                for row in rows {
                    guard let key = row["key"] as? String, let raw = row["value"] as? String else { continue }
                    let value = (try? JSONSerialization.jsonObject(with: Data(raw.utf8), options: [.fragmentsAllowed])).map { String(describing: $0) } ?? raw
                    metadata[key] = value
                }
                try EraLensContentVersion.validate(metadata: metadata, schemaVersion: expectedSchema, contractVersion: expectedContract)
                completion(.success([
                    "platform": self.platform.rawValue,
                    "protocolVersion": Self.protocolVersion,
                    "datasetVersion": metadata["dataset_version"] ?? "unknown",
                    "schemaVersion": expectedSchema,
                    "contractVersion": expectedContract,
                    "sourceGitSha": metadata["source_git_sha"] ?? "unknown",
                    "builtAt": metadata["built_at"] ?? "unknown",
                    "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown",
                    "appBuild": Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown",
                ]))
            } catch { completion(.failure(error)) }
        }
    }

    public static func isAppOrigin(_ url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }
        return components.scheme == "eralens" && components.host == "app" && components.user == nil && components.password == nil && components.port == nil
    }

    public static func allowsBridgeRequest(isMainFrame: Bool, origin: WKSecurityOrigin) -> Bool {
        isMainFrame && origin.protocol == "eralens" && origin.host == "app" && origin.port == 0
    }

    public static func allowsBridgeRequest(isMainFrame: Bool, scheme: String, host: String, port: Int) -> Bool {
        isMainFrame && scheme == "eralens" && host == "app" && port == 0
    }

    private static func replyOnMain(_ reply: @escaping (Any?, String?) -> Void, value: Any?, error: String?) {
        if Thread.isMainThread { reply(value, error) }
        else { DispatchQueue.main.async { reply(value, error) } }
    }
}
