@testable import MacAddress
import XCTest

final class MacAddressTests: XCTestCase {
    func testAppleRecommended() throws {
        let address = MacAddress.appStoreCompatible!
        let expectedAddress = (
            MacAddress(.builtIn("en0"))
                ?? MacAddress(.builtIn("en1"))
                ?? MacAddress(.nonBuiltIn("en0"))
        )
        XCTAssertEqual(address, expectedAddress)
    }

    func testReturnsRepresentation() throws {
        let address = MacAddress.appStoreCompatible!
        let addressString = address.stringRepresentation
        let reconstructedData = Data(
            addressString
                .split(separator: ":")
                .map { UInt8($0, radix: 16)! }
        )
        XCTAssertEqual(addressString.count, (6 * 2) + 5) // 6 octets, 5 colons
        XCTAssertEqual(address.rawData, reconstructedData)
    }
    
    func test_WhenGibberishNetworkInterfacePassed_ReturnsNil() throws {
        XCTAssertNil(MacAddress(.builtIn("asdjaiehq")))
        XCTAssertNil(MacAddress(.nonBuiltIn("asdjaiehq")))
        XCTAssertNil(MacAddress(.builtIn("en31")))
        XCTAssertNil(MacAddress(.nonBuiltIn("en31")))
        XCTAssertNil(MacAddress(.builtIn("")))
        XCTAssertNil(MacAddress(.nonBuiltIn("")))
        XCTAssertNil(MacAddress(.builtIn("😜💥")))
        XCTAssertNil(MacAddress(.nonBuiltIn("😜💥")))
    }

    func testInitPerformance() throws {
        measure {
            _ = MacAddress(.builtIn("en0"))
        }
    }

    func testInitPlusStringRepresentationPerformance() throws {
        measure {
            let address = MacAddress(.builtIn("en0"))
            _ = address?.stringRepresentation
        }
    }
}
