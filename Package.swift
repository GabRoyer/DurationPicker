// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "DurationPicker",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "DurationPicker",
      targets: ["DurationPicker"]),
    .library(
      name: "DurationPickerSwiftUI",
      targets: ["DurationPickerSwiftUI"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "DurationPicker",
      dependencies: []),
    .target(
      name: "DurationPickerSwiftUI",
      dependencies: ["DurationPicker"]
    ),
    .testTarget(
      name: "DurationPickerTests",
      dependencies: ["DurationPicker"]),
  ])
