# MacAddress

`MacAddress` is a Swift microlibrary for macOS that provides an easy way to obtain the MAC address of a device's network interface. This library is especially useful when working with Mac App Store receipt validation, as it implements the Apple's recommended fallback strategy (en0 builtin → en1 builtin → en0 non-builtin).

## Features

* Retrieve the MAC address of built-in and non-built-in network interfaces
* Obtain the MAC address as a formatted string
* App Store receipt validation compatible MAC address retrieval

## Requirements

* macOS 10.13+
* Swift 5.3+

## Installation

### Swift Package Manager

Add the following dependency to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/ivanmoskalev/MacAddress.git", from: "1.0.0")
]
```

Then, add MacAddress to your target's dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["MacAddress"]),
]
```

## Usage

```swift
import MacAddress

// Get the MAC address of the built-in "en0" network interface
if let macAddress = MacAddress(.builtIn("en0")) {
    print("Built-in MAC address: \(macAddress.stringRepresentation)")
}

// Get the MAC address of the non-built-in "en0" network interface
if let macAddress = MacAddress(.nonBuiltIn("en0")) {
    print("Non-built-in MAC address: \(macAddress.stringRepresentation)")
}

// Get the MAC address compatible with Mac App Store receipt validation
if let macAddress = MacAddress.appStoreCompatible {
    print("App Store compatible MAC address: \(macAddress.stringRepresentation)")
}
```
