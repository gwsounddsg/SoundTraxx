//
//  OscBundle.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation





public struct OscBundle: OscElement {
    public var timeTag: Timetag
    public var elements: [OscElement] = []
    public static let bundleID = "#bundle\0".data

    public var data: Data {
        get {
            var data = Data()
            data.append("#bundle".toBase32())
            data.append(timeTag.data)

            for element in elements {
                let elementData = element.data
                data.append(Int32(elementData.count).toData())
            }

            return data
        }
    }


    public init(_ elements: [OscElement] = [], timeTag: Timetag = 1) {
        self.timeTag = timeTag
        self.elements = elements
    }


    public mutating func add(_ elements: OscMessage...) {
        self.elements += elements
    }
}
