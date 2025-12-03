// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let years = 2015...2025
let yearTargets = years.map { year in
    Target.target(
        name: "Year\(year)",
        dependencies: ["AoCCommon"]
            + ([2015, 2016].contains(year)
                ? [.product(name: "Crypto", package: "swift-crypto")] : []),
        resources: [.process("Resources")]
    )
}
let yearDependencies = years.map { "Year\($0)" } + ["AoCCommon"]

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v15)],
    products: [.executable(name: "AoCApp", targets: ["App"])],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "AoCCommon")
    ] + yearTargets + [
        .executableTarget(name: "App", dependencies: yearDependencies.map { .byName(name: $0) })
    ]
)
