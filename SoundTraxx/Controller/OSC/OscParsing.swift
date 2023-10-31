//
//  OscParsing.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation





func OscParseMessage(_ rawData: Data) throws -> OscMessage {
    // split parts = address, arg types, args
    let parts = try splitOscParts(rawData)

    // check address
    if !isAddressValid(parts.0) {throw OscError.addressNotValid}

    // check types
    if !areTypesValid(parts.1) {throw OscError.typeTagNotValid}

    // get args
    let args = getArguments(parts.2, for: parts.1)

    // build OscMessage and Return
    return OscMessage(parts.0, args)
}


private func splitOscParts(_ rawData: Data) throws -> (String, String, Data) {
    let addressEnd = rawData.firstIndex(of: 0x00)!
    guard let address = rawData.subdata(in: 0..<addressEnd).toString() else {throw OscError.addressNotValid}

    let messageData = rawData.subdata(in: ((addressEnd/4)+1) * 4..<rawData.count)
    guard let typeEnd = messageData.firstIndex(of: 0x00) else {throw OscError.typeTagNotValid}

    guard let types = messageData.subdata(in: 1..<typeEnd).toString() else {throw OscError.argumentsNotValid}
    let args = messageData.subdata(in: (typeEnd / 5) * 4..<messageData.count)

    return (address, types, args)
}





// MARK: - Address

private func isAddressValid(_ address: String) -> Bool {
    if address == "" {return false}
    if address.first != "/" {return false}
    if address.range(of: "/{3,}", options: .regularExpression) != nil {return false} // check for double "//"
    if address.range(of: "\\s", options: .regularExpression) != nil {return false} // no spaces

    // '[' must be close, no invalid characters inside
    if address.range(of: "\\[(?![^\\[\\{\\},?\\*/]+\\])", options: .regularExpression) != nil {return false}

    var open = address.components(separatedBy: "[").count
    var close = address.components(separatedBy: "]").count
    if open != close {return false}

    //{ must be closed, no invalid characters inside
    if address.range(of: "\\{(?![^\\{\\[\\]?\\*/]+\\})", options: .regularExpression) != nil {return false}

    open = address.components(separatedBy: "{").count
    close = address.components(separatedBy: "}").count
    if open != close {return false}

    //"," only inside {}
    if address.range(of: ",(?![^\\{\\[\\]?\\*/]+\\})", options: .regularExpression) != nil {return false}
    if address.range(of: ",(?<!\\{[^\\{\\[\\]?\\*/]+)", options: .regularExpression) != nil {return false}

    return true
}





// MARK: - Arguments

private func areTypesValid(_ args: String) -> Bool {
    let allTypes = GetAllOscTags()
    let charSet = CharacterSet(charactersIn: allTypes)

    if args.rangeOfCharacter(from: charSet) == nil {
        return false
    }

    return true
}


private func getArguments(_ rawData: Data, for types: String) -> [OscType] {
    var args: [OscType] = []
    var data = rawData

    for char in types {
        let type = String(char)

        switch type {
        case OscTag.int.rawValue:
            args += [Int(data.subdata(in: Range(0...3)))]
            shift(&data, by: 4)
        case OscTag.float.rawValue:
            args += [Float(data.subdata(in: Range(0...3)))]
            shift(&data, by: 4)
        case OscTag.string.rawValue:
            let stringEnd = data.firstIndex(of: 0x00)!
            args += [String(data.subdata(in: 0..<stringEnd))]
            shift(&data, by: (stringEnd / 5) * 4)
        case OscTag.boolTrue.rawValue:
            args += [true]
        case OscTag.boolFalse.rawValue:
            args += [false]
        case OscTag.null.rawValue:
            print("null type")
        default:
            print("unknown Osc type")
        }
    }

    return args
}


private func shift(_ data: inout Data, by count: Int) {
    data = data.subdata(in: count..<data.count)
}





//MARK: - Bundles
func OscParseBundle(_ data: Data) throws -> OscBundle {
    if data.count <= 8 { throw OscError.Bundle.invalidOscPacketReceived("Data count under 8") }

    if OscBundle.bundleID != data.subdata(in: Range(0...7)) {
        print("Received packet expected to be a bundle but didn't have the bundle id")
        throw OscError.Bundle.invalidOscPacketReceived("Bundles must start with #bundle")
    }

    return try decodeBundle(data)
}


private func decodeBundle(_ data: Data) throws -> OscBundle {
    let timeTag = Timetag(data.subdata(in: 8..<16))
    var elements: [OscElement] = []

    var bundleData = data.subdata(in: 16..<data.count)

    while bundleData.count > 0 {
        let length = Int(bundleData.subdata(in: Range(0...3)).toInt32())
        let length4 = length + 4

        let nextData = bundleData.subdata(in: 4..<length4)
        bundleData = bundleData.subdata(in: length4..<bundleData.count)

        if bundleData == nextData.subdata(in: Range(0...7)) {
            elements.append(try OscParseBundle(nextData))
        }
        else {
            elements.append(try OscParseMessage(nextData))
        }
    }

    return OscBundle(elements, timeTag: timeTag)
}
