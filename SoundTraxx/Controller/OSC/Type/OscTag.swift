//
//  OscTag.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation



public enum OscTag: String, CaseIterable {
    case int = "i"
    case float = "f"
    case string = "s"
    case blob = "b"
    case boolTrue = "T"
    case boolFalse = "F"

    case time = "t"
    case null = "N"
    case impulse = "I"
}


func GetAllOscTags() -> String {
    let tags = OscTag.allCases
    var allTypes = ""

    for tag in tags {
        allTypes += tag.rawValue
    }

    return allTypes
}
