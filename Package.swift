// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription



let package = Package(
	name: "PopH264",
	
	platforms: [
		.iOS(.v15),
		.macOS(.v10_15)
	],
	

	products: [
		.library(
			name: "PopH264",
			targets: [
				"PopH264"
			]),
	],
	targets: [

		.target(
			name: "PopH264",
			/* include all targets where .h contents need to be accessible to swift */
			dependencies: ["PopH264Objc","PopH264Framework"],
			path: "./PopH264Swift"
		),
		
		.binaryTarget(
					name: "PopH264Framework",
					path: "PopH264.xcframework"
				),
		
		.target(
			name: "PopH264Objc",
			dependencies: [],
			path: "./PopH264Objc",
			//publicHeadersPath: ".",	//	not using include/ seems to have some errors resolving symbols? (this may before my extern c's)
			cxxSettings: [
				.headerSearchPath("./"),	//	this allows headers in same place as .cpp
			]
		)
		,
/*
		.testTarget(
			name: "PopH264Tests",
			dependencies: ["PopH264"]
		),
 */
	]
)
