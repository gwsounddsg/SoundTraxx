//
//  TimeTag.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation


public typealias Timetag = UInt64



extension Timetag: OscType {
    public var tag: OscTag {
        get { return .time }
    }


    public var data: Data {
        get {
            var int = self.bigEndian
            let buffer = UnsafeBufferPointer(start: &int, count: 1)
            return Data(buffer: buffer)
        }
    }


    public var secondsSince1900: Double {
        get {
            return Double(self / 0x1_0000_0000)
        }
    }


    public var secondsSinceNow: Double {
        get {
            if self > 0 {
                return Double((self - Date().oscTime) / 0x1_0000_0000)
            }
            else {
                return 0.0
            }
        }
    }


    public init(secondsSince1900 seconds: Double) {
        self = Date().oscTime
        self += UInt64(seconds * 0x1_0000_0000)
    }


    public init(secondsSinceNow seconds: Double) {
        self = UInt64(seconds * 0x1_0000_0000)
    }


    public init(_ data: Data) {
        var int = UInt64()
        let buffer = UnsafeMutableBufferPointer(start: &int, count: 1)
        _ = data.copyBytes(to: buffer)
        self = int.byteSwapped
    }
}
