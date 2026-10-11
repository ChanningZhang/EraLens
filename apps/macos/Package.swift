// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EraLensMac",
    platforms: [.macOS("13.1")],
    products: [.executable(name: "EraLens", targets: ["EraLensMac"])],
    dependencies: [.package(path: "../../packages/apple-native")],
    targets: [
        .executableTarget(name: "EraLensMac", dependencies: [.product(name: "EraLensNativeCore", package: "apple-native")], path: "Sources/EraLensMac"),
    ]
)
