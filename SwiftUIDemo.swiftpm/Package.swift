// swift-tools-version: 5.9
import PackageDescription
import AppleProductTypes

let package = Package(
    name: "SwiftUIDemo",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "SwiftUIDemo",
            targets: ["AppModule"],
            bundleIdentifier: "com.example.swiftuidemo",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            supportedDeviceFamilies: [.pad, .phone],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeLeft,
                .landscapeRight
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
