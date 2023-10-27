//
//  NetworkManager.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import Foundation



struct NetworkManager {
    var listener: ListenerOsc
    
    
    init() {
        listener = ListenerOsc(4242, "my osc queue", delegate: nil)
    }
}
