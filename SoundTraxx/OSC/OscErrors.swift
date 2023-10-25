//
//  OscErrors.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation



enum OSCError: Error {
    case addressNotValid
    case typeTagNotValid
    case argumentsNotValid

    enum Bundle: Error {
        case invalidOSCPacketReceived(String)
    }
}
