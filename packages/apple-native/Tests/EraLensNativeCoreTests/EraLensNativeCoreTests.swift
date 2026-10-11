import Foundation
import SQLite3
import XCTest
@testable import EraLensNativeCore

final class EraLensNativeCoreTests: XCTestCase {
    func testReadsBoundChineseAndNullValues() async throws {
        let databaseURL = try temporaryDatabase()
        defer { try? FileManager.default.removeItem(at: databaseURL.deletingLastPathComponent()) }
        let database = EraLensReadOnlyDatabase(url: databaseURL)
        let rows = try await query(database, "SELECT ? AS label, ? AS missing", ["秦始皇", NSNull()])
        XCTAssertEqual(rows.count, 1)
        XCTAssertEqual(rows[0]["label"] as? String, "秦始皇")
        XCTAssertTrue(rows[0]["missing"] is NSNull)
        try await close(database)
    }

    func testRejectsWritesMultipleStatementsAndWrongBindingCount() async throws {
        let databaseURL = try temporaryDatabase()
        defer { try? FileManager.default.removeItem(at: databaseURL.deletingLastPathComponent()) }
        let database = EraLensReadOnlyDatabase(url: databaseURL)
        await XCTAssertThrowsErrorAsync(try await query(database, "DELETE FROM records", []))
        await XCTAssertThrowsErrorAsync(try await query(database, "SELECT 1; SELECT 2", []))
        await XCTAssertThrowsErrorAsync(try await query(database, "SELECT ?", []))
        let rows = try await query(database, "SELECT COUNT(*) AS count FROM records", [])
        XCTAssertEqual((rows[0]["count"] as? NSNumber)?.intValue, 1)
        try await close(database)
    }

    func testSchemeHandlerRejectsTraversalAndSymlinks() throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        let outside = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: outside, withIntermediateDirectories: true)
        defer {
            try? FileManager.default.removeItem(at: directory)
            try? FileManager.default.removeItem(at: outside)
        }
        try Data("ok".utf8).write(to: directory.appendingPathComponent("index.html"))
        try Data("secret".utf8).write(to: outside.appendingPathComponent("secret.txt"))
        try FileManager.default.createSymbolicLink(at: directory.appendingPathComponent("escape.txt"), withDestinationURL: outside.appendingPathComponent("secret.txt"))
        let handler = EraLensResourceSchemeHandler(root: directory)

        XCTAssertEqual(handler.resourceURL(for: URL(string: "eralens://app/index.html")!)?.lastPathComponent, "index.html")
        XCTAssertNil(handler.resourceURL(for: URL(string: "eralens://app/../../etc/passwd")!))
        XCTAssertNil(handler.resourceURL(for: URL(string: "eralens://app/escape.txt")!))
        XCTAssertNil(handler.resourceURL(for: URL(string: "eralens://app/index.html?outside=1")!))
        XCTAssertNil(handler.resourceURL(for: URL(string: "https://app/index.html")!))
        XCTAssertEqual(EraLensResourceSchemeHandler.mimeType(for: "woff2"), "font/woff2")
    }

    func testOnlyAppOriginIsTrusted() {
        XCTAssertTrue(EraLensWebBridge.isAppOrigin(URL(string: "eralens://app/index.html")!))
        XCTAssertFalse(EraLensWebBridge.isAppOrigin(URL(string: "https://app/index.html")!))
        XCTAssertFalse(EraLensWebBridge.isAppOrigin(URL(string: "eralens://evil/index.html")!))
        XCTAssertFalse(EraLensWebBridge.isAppOrigin(URL(string: "eralens://user@app/index.html")!))
        XCTAssertTrue(EraLensWebBridge.allowsBridgeRequest(isMainFrame: true, scheme: "eralens", host: "app", port: 0))
        XCTAssertFalse(EraLensWebBridge.allowsBridgeRequest(isMainFrame: false, scheme: "eralens", host: "app", port: 0))
    }

    func testSettingsPersistUsingAppNamespace() {
        let suite = "EraLensNativeCoreTests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defer { defaults.removePersistentDomain(forName: suite) }
        let settings = EraLensSettingsStore(defaults: defaults)

        XCTAssertNil(settings.get("timeline-viewport.v1"))
        settings.set("{\"center\":42}", for: "timeline-viewport.v1")
        XCTAssertEqual(settings.get("timeline-viewport.v1"), "{\"center\":42}")
        XCTAssertEqual(defaults.string(forKey: "eralens.setting.timeline-viewport.v1"), "{\"center\":42}")
    }

    func testRejectsIncompatiblePackagedDatabaseVersions() throws {
        XCTAssertNoThrow(try EraLensContentVersion.validate(metadata: ["schema_version": "15", "contract_version": "16"], schemaVersion: 15, contractVersion: 16))
        XCTAssertThrowsError(try EraLensContentVersion.validate(metadata: ["schema_version": "14", "contract_version": "16"], schemaVersion: 15, contractVersion: 16))
        XCTAssertThrowsError(try EraLensContentVersion.validate(metadata: ["schema_version": "15", "contract_version": "15"], schemaVersion: 15, contractVersion: 16))
    }

    func testCloseWaitsUntilEarlierQueriesComplete() async throws {
        let databaseURL = try temporaryDatabase()
        defer { try? FileManager.default.removeItem(at: databaseURL.deletingLastPathComponent()) }
        let database = EraLensReadOnlyDatabase(url: databaseURL)
        let first = try await query(database, "SELECT 1 AS value", [])
        try await close(database)
        let afterClose = try await query(database, "SELECT 2 AS value", [])
        XCTAssertEqual((first[0]["value"] as? NSNumber)?.intValue, 1)
        XCTAssertEqual((afterClose[0]["value"] as? NSNumber)?.intValue, 2)
    }

    private func query(_ database: EraLensReadOnlyDatabase, _ sql: String, _ values: [Any]) async throws -> [[String: Any]] {
        try await withCheckedThrowingContinuation { continuation in
            database.query(sql, values) { continuation.resume(with: $0) }
        }
    }

    private func close(_ database: EraLensReadOnlyDatabase) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            database.close { error in
                if let error { continuation.resume(throwing: error) }
                else { continuation.resume(returning: ()) }
            }
        }
    }

    private func temporaryDatabase() throws -> URL {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent("content.sqlite")
        var database: OpaquePointer?
        XCTAssertEqual(sqlite3_open(url.path, &database), SQLITE_OK)
        defer { sqlite3_close(database) }
        XCTAssertEqual(sqlite3_exec(database, "CREATE TABLE records (id INTEGER); INSERT INTO records VALUES (1);", nil, nil, nil), SQLITE_OK)
        return url
    }
}

private func XCTAssertThrowsErrorAsync<T>(_ expression: @autoclosure () async throws -> T, file: StaticString = #filePath, line: UInt = #line) async {
    do {
        _ = try await expression()
        XCTFail("Expected an error", file: file, line: line)
    } catch {}
}
