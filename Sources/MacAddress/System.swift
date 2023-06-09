import Foundation
import IOKit

func macAddressFor(_ interfaceRequest: MacAddress.NetworkInterface) -> Data? {
    var iterator = io_iterator_t()
    defer {
        if iterator != IO_OBJECT_NULL {
            IOObjectRelease(iterator)
        }
    }

    guard let matchingDict = IOBSDNameMatching(kIOMasterPortDefault, 0, interfaceRequest.name),
          IOServiceGetMatchingServices(kIOMasterPortDefault,
                                       matchingDict as CFDictionary,
                                       &iterator) == KERN_SUCCESS,
          iterator != IO_OBJECT_NULL
    else {
        return nil
    }

    var candidate = IOIteratorNext(iterator)
    while candidate != IO_OBJECT_NULL {
        if let cftype = IORegistryEntryCreateCFProperty(candidate,
                                                        "IOBuiltin" as CFString,
                                                        kCFAllocatorDefault,
                                                        0) {
            // swiftlint:disable:next force_cast
            let isBuiltIn = cftype.takeRetainedValue() as! CFBoolean
            if interfaceRequest.isBuiltIn == CFBooleanGetValue(isBuiltIn) {
                let property = IORegistryEntrySearchCFProperty(
                    candidate,
                    kIOServicePlane,
                    "IOMACAddress" as CFString,
                    kCFAllocatorDefault,
                    IOOptionBits(kIORegistryIterateRecursively | kIORegistryIterateParents)
                ) as? Data
                IOObjectRelease(candidate)
                return property
            }
        }

        IOObjectRelease(candidate)
        candidate = IOIteratorNext(iterator)
    }

    return nil
}

private extension MacAddress.NetworkInterface {
    var name: String {
        switch self {
        case let .builtIn(name), let .nonBuiltIn(name):
            return name
        }
    }

    var isBuiltIn: Bool {
        switch self {
        case .builtIn: return true
        case .nonBuiltIn: return false
        }
    }
}
