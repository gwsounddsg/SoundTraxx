//
//  Log.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import Foundation


struct Log {
    var data: String = ""
    
    
    mutating func add(_ text: String) {
        data += text + "\n"
    }
}
