// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UI2BHR",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UI2BHR",
            targets: ["UI2BHR"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.0.0"),
        .package(url: "https://github.com/SwiftKickMobile/SwiftMessages.git", from: "9.0.0"),  // Add SwiftMessages here
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UI2BHR",
            dependencies: [
                "SDWebImage",
                "SwiftMessages",  // Declare SwiftMessages as a target dependency
            ]
        ),
        .testTarget(
            name: "UI2BHRTests",
            dependencies: ["UI2BHR"]),
    ]
)
