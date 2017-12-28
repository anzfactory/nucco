// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "questions",
    products: [
        .library(name: "App", targets: ["App"]),
        .executable(name: "Run", targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.0")),
        .package(url: "https://github.com/vapor/leaf-provider.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.3.0")),
        // .package(url: "https://github.com/vapor/mysql-provider.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/vapor-community/postgresql-provider.git", .upToNextMajor(from: "2.1.0")),
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "LeafProvider", "FluentProvider", /*"MySQLProvider",*/ "PostgreSQLProvider"],
               exclude: [
                   "Config",
                   "Database",
                   "Public",
                   "Resources"
               ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App", "Testing"])
    ]
)

// mysql -u root -p Z6yYTqVU

