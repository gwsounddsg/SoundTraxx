//
//  ViewController.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import SwiftUI




class ViewController: ObservableObject, ListenerOscDelegate, ListenerDelegate {
    @Published var log = Log(data: "here's a log again")
    
    var network: NetworkManager
    
    
    init() {
        network = NetworkManager()
        network.listener.delegateOsc = self
        
        do {
            try network.listener.connect()
        }
        catch let error {
            print("\(error)")
        }
    }
    
    
    func oscReceivedMessage(_ message: OscMessage) {
        DispatchQueue.main.async {
            self.log.data = "\(message.address) \(message.getArguments())"
        }
    }
    
    func oscReceivedBundle(_ bundle: OscBundle) {
        
    }
    
    
    func listenerReceived(_ data: Data) {
        
    }
    
    
    func sendMessage() {
        let message = OscMessage("/sending/to/max", [4])
        network.client.send(message)
    }
}
