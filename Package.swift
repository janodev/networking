// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "networking",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "NetworkingDynamic", type: .dynamic, targets: ["Networking"]),
        .library(name: "NetworkingStatic", type: .static, targets: ["Networking"])
    ],
    dependencies: [
        .package(name: "session", url: "git@github.com:janodev/session.git", from: "1.0.0"),
        .package(name: "log", url: "git@github.com:janodev/log.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "SessionDynamic", package: "session"),
                .product(name: "LogDynamic", package: "log")
            ],
            path: "sources/main",
            resources: [
                .process("resources")
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking",
                .product(name: "SessionDynamic", package: "session"),
                .product(name: "LogDynamic", package: "log")
            ],
            path: "sources/tests",
            resources: [
                .process("resources")
            ]
        )
    ]
)
