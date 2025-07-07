// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "ClarioKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ClarioKit",
            targets: ["ClarioKit"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "ClarioKit",
            url: "https://github.com/yohannescodes/ClarioKit/releases/download/v1.0.0/ClarioKit.xcframework.zip",
            checksum: ""
        )
    ]
)
