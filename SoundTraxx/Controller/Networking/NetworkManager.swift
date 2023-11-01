//
//  NetworkManager.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import Foundation



struct NetworkManager {
    var listener: ListenerOsc?
    var client: ClientOsc?
    
    
    init() {
        
    }
    
    
    mutating func setupListener(_ delegate: ListenerOscDelegate) {
        listener = ListenerOsc(4242, "my osc queue", delegate: delegate)
        listener!.delegateOsc = delegate
        
        do {
            try listener!.connect()
        }
        catch {
            print("listener connect error: \(String(describing: error))")
        }
    }
    
    
    mutating func setupClient() {
        client = ClientOsc()
    }
    
    
    func connectClient() {
        client?.connect()
    }
}
