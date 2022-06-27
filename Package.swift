// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PopH264",
	platforms: [
		.macOS(.v10_14), .iOS(.v13)
	],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PopH264",
            targets: ["PopH264"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
		.binaryTarget(
			name: "PopH264",
			url: "https://github.com/NewChromantics/PopH264/releases/download/v1.3.41/PopH264.xcframework.zip",
			checksum: "8a378470a2ab720f2ee6ecf4e7a5e202a3674660c31e43d95d672fe76d61d68c"
		),
        
    ]
)
