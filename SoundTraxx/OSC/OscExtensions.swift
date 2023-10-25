//
//  OscExtensions.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation


extension Bool: OscType {
    public var tag: OscTag {
        get {
            return self ? .boolTrue : .boolFalse
        }
    }

    public var data: Data {
        get { return Data() }
    }
}


extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }


    func toInt32() -> Int32 {
        var int = Int32();
        let buffer = UnsafeMutableBufferPointer(start: &int, count: 1)
        _ = self.copyBytes(to: buffer)
        return int.byteSwapped
    }
}


extension Date {
    var oscTime: Timetag {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = RFC3339DateFormatter.date(from: "1900-01-01T00:00:00-00:00")

        return Timetag(Date().timeIntervalSince(date!) * 0x1_0000_0000)
    }
}


extension Double: OSCType {
    public var tag: OSCTag {
        get { return .float }
    }

    public var data: Data {
        let bytes: [UInt8] = withUnsafeBytes(of: Float(self.bitPattern.bigEndian), Array.init)
        return Data(bytes)
    }
}


extension Float: OSCType {
    public var tag: OSCTag {
        get { return .float }
    }

    public var data: Data {
        get {
            let bytes: [UInt8] = withUnsafeBytes(of: self.bitPattern.bigEndian, Array.init)
            return Data(bytes)
        }
    }

    init(_ data: Data) {
        self = Float(bitPattern: UInt32(bigEndian: data.withUnsafeBytes { $0.load(as: UInt32.self) }))
    }
}


extension Int: OSCType {
    public var tag: OSCTag {
        get { return .int }
    }

    public var data: Data {
        get {
            let bytes: [UInt8] = withUnsafeBytes(of: Int32(self).bigEndian, Array.init)
            return Data(bytes)
        }
    }

    init (_ data: Data) {
        self = Int(data.withUnsafeBytes { $0.load(fromByteOffset: 0, as: Int32.self).bigEndian })
    }
}


extension Int32 {
    func toData() -> Data {
        var int = self.bigEndian
        let buffer = UnsafeBufferPointer(start: &int, count: 1)
        return Data(buffer: buffer)
    }
}


extension String: OSCType {
    public var tag: OSCTag {
        get { return .string }
    }

    public var data: Data {
        get {
            var data = self.data(using: .utf8)!

            for _ in 1...(4 - data.count%4) {
                var null = UInt8(0)
                data.append(&null, count: 1)
            }

            return data
        }
    }

    init(_ data: Data) {
        self = String(data: data, encoding: .utf8)!
    }


    func toBase32() -> Data {
        var data = self.data(using: .utf8)!
        var val: UInt8 = 0

        for _ in 1...(4 - (data.count % 4)) {
            data.append(&val, count: 1)
        }

        return data
    }
}


extension UInt32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
}
