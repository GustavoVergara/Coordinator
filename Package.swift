// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinator",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
//        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0")),
//        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.1.2")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Coordinator",
            dependencies: []
        ),
        .target(
            name: "TestKit",
            dependencies: ["Coordinator"]
        ),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: ["Coordinator", "TestKit"]//, "Quick", "Nimble"]
        ),
    ]
)
