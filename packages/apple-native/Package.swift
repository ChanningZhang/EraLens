// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EraLensAppleNative",
    platforms: [.iOS("16.2"), .macOS("13.1")],
    products: [.library(name: "EraLensNativeCore", targets: ["EraLensNativeCore"])],
    targets: [
        .target(name: "EraLensNativeCore", path: "Sources/EraLensNativeCore", linkerSettings: [.linkedLibrary("sqlite3")]),
        .testTarget(name: "EraLensNativeCoreTests", dependencies: ["EraLensNativeCore"], path: "Tests/EraLensNativeCoreTests"),
    ]
)
