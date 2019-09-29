// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DisposeBag",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "DisposeBag",
      targets: ["DisposeBag"]
    ),
  ],
  targets: [
    .target(
      name: "DisposeBag",
      dependencies: []
    ),
    .testTarget(
      name: "DisposeBagTests",
      dependencies: ["DisposeBag"]
    ),
  ]
)
