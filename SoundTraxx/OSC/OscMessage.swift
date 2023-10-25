//
//  OscMessage.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation





public struct OscMessage: OscElement {
    public var address: String = ""
    public var arguments: [OscType?] = []


    public var data: Data {
        get {
            var data = Data()

            // add address
            data.append(address.toBase32())

            // add types
            var types = ","
            if arguments.isEmpty {
                types += OscTag.null.rawValue
            } else {
                for arg in arguments {
                    types += arg!.tag.rawValue
                }
            }
            data.append(types.toBase32())

            // add arg(s)
            for arg in arguments {
                data.append(arg!.data)
            }

            return data
        }
    }


    init() {}


    init(_ address: String, _ arguments: [OscType]) {
        self.address = address
        self.arguments = arguments
    }


    func addressPart(_ index: Int) -> String {
        let elements = address.split(separator: "/")
        return String(elements[index])
    }
}
