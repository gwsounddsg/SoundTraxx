//
//  OscType.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/25/23.
//

import Foundation



public protocol OscType {
    var data: Data { get }
    var tag: OscTag { get }
}
