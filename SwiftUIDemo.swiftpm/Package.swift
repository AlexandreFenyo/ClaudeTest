// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "SwiftUIDemo",
    platforms: [
        .iOS("16.0")
    ],
    targets: [
        .executableTarget(
            name: "SwiftUIDemo",
            path: "Sources"
        )
    ]
)
