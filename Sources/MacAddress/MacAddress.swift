import Foundation
import IOKit

/// A structure representing a MAC address.
public struct MacAddress: Equatable, Hashable {
    /// The raw bytes of the MAC address.
    public let rawData: Data

    /// An enumeration representing the types of queryable network interfaces.
    public enum NetworkInterface {
        case builtIn(String)
        case nonBuiltIn(String)
    }

    /// Initializes a `MacAddress` instance with the specified network interface.
    ///
    /// - Parameter interface: The network interface for which to obtain the MAC address.
    /// - Returns: An optional `MacAddress` instance if successful, otherwise `nil`.
    public init?(_ interface: NetworkInterface) {
        guard let data = macAddressFor(interface) else { return nil }
        rawData = data
    }

    /// A string representation of the MAC address.
    public var stringRepresentation: String {
        rawData
            .map { String(format: "%02X", $0) }
            .joined(separator: ":")
    }
}

public extension MacAddress {
    /// A `MacAddress` instance that is compatible with the Mac App Store receipt validation.
    /// More details: https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device
    static let appStoreCompatible = (
        MacAddress(.builtIn("en0"))
            ?? MacAddress(.builtIn("en1"))
            ?? MacAddress(.nonBuiltIn("en0"))
    )
}
