//
//  RTTrPM.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation





public struct RTTrPM {
    
    public var trackable: Trackable?
    
    
    public init(_ array: inout [UInt8]) throws {
        let module = RTTCode(rawValue: array[0]) ?? .unknown
        
        switch module {
            case .trackable, .trackableWithTimestamp:
                trackable = try Trackable(&array)
            default:
                throw RTTError.badModuleType(module)
        }
    }
    
    
    public func print() {
        trackable?.print()
    }
}
