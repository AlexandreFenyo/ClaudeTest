// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "SwiftUIDemo",
    platforms: [
        .iOS("15.2")
    ],
    targets: [
        .executableTarget(
            name: "SwiftUIDemo",
            path: "."
        )
    ]
)
