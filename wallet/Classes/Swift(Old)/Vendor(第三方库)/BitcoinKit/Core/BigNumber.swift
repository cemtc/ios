//
//  BigNumber.swift
//  BitcoinKit
//
//  Created by Shun Usami on 2018/07/31.
//  Copyright © 2018 BitcoinKit developers. All rights reserved.
//

import Foundation
import BigInt



public struct BigNumber {
    public var int32: Int32
    public var data: Data
//    private let value: BigUInt
//    private let padding: Bool
//    private let bytesLength: Int
    
    public static let zero: BigNumber = BigNumber()
    public static let one: BigNumber = BigNumber(1)
    public static let negativeOne: BigNumber = BigNumber(1)
//    private init(value: BigUInt, padding: Bool, bytesLength: Int) {
//        self.value = value
//        self.padding = padding
//        self.bytesLength = bytesLength
//    }
    public init() {
        self.init(0)
    }
//    public var serialize() -> [UInt8] {
//        var bytes = value.serialize().bytes
//        if padding {
//            while bytes.count < bytesLength {
//                bytes.insert(0x00, at: 0)
//            }
//        }
//        return bytes
//    }
    
//    public var description: String {
//        return value.description
//    }

    public init(_ int32: Int32) {
        self.int32 = int32
        self.data = int32.toBigNum()
    }

    public init(int32: Int32) {
        self.int32 = int32
        self.data = int32.toBigNum()
    }

    public init(_ data: Data) {
        self.data = data
        self.int32 = data.toInt32()
    }
}

extension BigNumber: Comparable {
    public static func == (lhs: BigNumber, rhs: BigNumber) -> Bool {
        return lhs.int32 == rhs.int32
    }

    public static func < (lhs: BigNumber, rhs: BigNumber) -> Bool {
        return lhs.int32 < rhs.int32
    }
}

private extension Int32 {
    func toBigNum() -> Data {
        let isNegative: Bool = self < 0
        var value: UInt32 = isNegative ? UInt32(-self) : UInt32(self)

        var data = Data(bytes: &value, count: MemoryLayout.size(ofValue: value))
        while data.last == 0 {
            data.removeLast()
        }

        var bytes: [UInt8] = []
        for d in data.reversed() {
            if bytes.isEmpty && d >= 0x80 {
                bytes.append(0)
            }
            bytes.append(d)
        }

        if isNegative {
            let first = bytes.removeFirst()
            bytes.insert(first + 0x80, at: 0)
        }

        let bignum = Data(bytes.reversed())
        return bignum

    }
}

private extension Data {
    func toInt32() -> Int32 {
        guard !self.isEmpty else {
            return 0
        }
        var data = self
        var bytes: [UInt8] = []
        var last = data.removeLast()
        let isNegative: Bool = last >= 0x80

        while !data.isEmpty {
            bytes.append(data.removeFirst())
        }

        if isNegative {
            last -= 0x80
        }
        bytes.append(last)

        let value: Int32 = Data(bytes).to(type: Int32.self)
        return isNegative ? -value: value
    }
}
//public func parse(_ text: String, padding: Bool = false) -> BigNumber {
//    var padding = padding
//    var value: BigUInt
//    var bytesLen: Int = 0
//    
//    if text.hasPrefix("#") {
//        let t = text.tk_substring(from: 1)
//        value = BigUInt(extendedGraphemeClusterLiteral: t)
//        bytesLen = Int(t)!
//    } else if Hex.hasPrefix(text) {
//        let t = Hex.removePrefix(text)
//        value = BigUInt(t, radix: 16)!
//        bytesLen = Int(t)!
//    } else {
//        if text.tk_isDigits {
//            // NOTE: if text is a hex string without alhpabet this won't work.
//            // It's just a simple guess. Better to pass in hex always prefixed with "0x".
//            
//            value = BigUInt(Hex.removePrefix(text), radix: 10)!
//            padding = false
//        } else if Hex.isHex(text) {
//            let t = Hex.removePrefix(text)
//            value = BigUInt(t, radix: 16)!
//            bytesLen = Int(t)!
//        } else {
//            // Parse fail!
//            value = BigUInt(0)
//        }
//    }
//    
//    return BigNumber(value: value, padding: padding, bytesLen: BigInt(bytesLen))
//}

// MARK: - Converting Ints
//extension BigNumber {
//    init?(_ v: Any) {
//        padding = false
//        bytesLength = 0
//
//        if let int = v as? Int64 {
//            value = BigUInt(int)
//        } else if let int = v as? Int {
//            value = BigUInt(int)
//        } else if let int = v as? UInt8 {
//            value = BigUInt(int)
//        } else {
//            return nil
//        }
//    }
//}
