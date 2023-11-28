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
        data += getTime() + " = " + text + "\n"
    }
    
    
    private func getTime() -> String {
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: time)
    }
}
