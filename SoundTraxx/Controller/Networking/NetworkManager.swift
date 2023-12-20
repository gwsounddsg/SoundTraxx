//
//  NetworkManager.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import Foundation



struct NetworkManager {
    var listenerOsc: ListenerOsc?
    var listenerRttrp: ListenerRttrp?
    var client: ClientOsc?
    
    
    init() {
        
    }
    
    
    mutating func setupListenerOsc(_ delegate: ListenerOscDelegate) {
        listenerOsc = ListenerOsc(4242, "my osc queue", delegate: delegate)
        listenerOsc!.delegateOsc = delegate
        
        do {
            try listenerOsc!.connect()
        }
        catch {
            print("listenerOsc connect error: \(String(describing: error))")
        }
    }
    
    
    mutating func setupListenerRttrpm(_ delegate: ListenerRttrpDelegate) {
        listenerRttrp = ListenerRttrp(24002, "listener rttrpm", delegate: delegate)
        listenerRttrp!.delegateRttrpm = delegate
        
        do {
            try listenerRttrp!.connect()
        }
        catch {
            print("listenerRttrpm connect error: \(String(describing: error))")
        }
    }
    
    
    mutating func setupClient() {
        client = ClientOsc()
    }
    
    
    func connectClient() {
        client?.connect()
    }
}
