// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "randomuserapi",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "RandomuserApiDynamic", type: .dynamic, targets: ["RandomuserApi"]),
        .library(name: "RandomuserApiStatic", type: .static, targets: ["RandomuserApi"])
    ],
    dependencies: [
        .package(name: "networking", path: ".."),
        .package(name: "session", url: "git@github.com:janodev/session.git", from: "1.0.0"),
        .package(name: "log", url: "git@github.com:janodev/log.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "RandomuserApi",
            dependencies: [
                .product(name: "NetworkingDynamic", package: "networking"),
                .product(name: "LogDynamic", package: "log")
            ],
            path: "sources/main"
        ),
        .testTarget(
            name: "RandomuserApiTests",
            dependencies: [
                "RandomuserApi",
                .product(name: "LogDynamic", package: "log"),
                .product(name: "SessionDynamic", package: "session"),
            ],
            path: "sources/tests",
            resources: [
                .process("resources")
            ]
        )
    ]
)
