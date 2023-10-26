//
//  Utility.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/26/23.
//

import Foundation



let LOGGING = true

/// Prints with formatted tabbing if LOGGING true
func logging(_ msg: String, shiftRight: Int = 0) {
    if LOGGING {
        var shift = shiftRight
        while shift > 0 {
            print("|\t", terminator: "")
            shift -= 1
        }
        print(msg)
    }
}
