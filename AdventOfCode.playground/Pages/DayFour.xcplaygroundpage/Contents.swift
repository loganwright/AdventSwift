//: [Previous](@previous)

import Foundation

extension NSData {
    var bytesArray: [UInt8] {
        var bytes: [UInt8] = [UInt8](count: length, repeatedValue: 0)
        getBytes(&bytes, length: bytes.count)
        return bytes
    }

    var hexString: String {
        return bytesArray.lazy.reduce("") { $0 + String(format:"%02x", $1) }
    }

    subscript(range: Range<Int>) -> NSData? {
        guard range.startIndex >= 0 else { return nil }
        guard length >= range.endIndex else { return nil }
        let rangeLength = range.endIndex - range.startIndex
        let nsrange = NSMakeRange(range.startIndex, rangeLength)
        return subdataWithRange(nsrange)
    }
}

func mineAdventCoins(passcode: String, leadingZeros: Int = 5) -> UInt64? {
    let prefixRange = 0..<leadingZeros
    let prefixString = prefixRange
        .map { _ in "0" }
        .joinWithSeparator("")
    
    for interval in 1..<UInt64.max {
        let combination = passcode + "\(interval)"
        guard let data = combination.dataUsingEncoding(NSUTF8StringEncoding) else { continue }
        guard let prefix = data[prefixRange]?.hexString where prefix == prefixString else { continue }
        return interval
    }

    return nil
}

// Part 1
mineAdventCoins(DayFourArgument)

// Part 2
mineAdventCoins(DayFourArgument, leadingZeros: 6)
