//
//  ViewController.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import SwiftUI


class ViewController: ObservableObject, ListenerOscDelegate {
    @Published var log = Log()
    @Published var patch: [Patch] = []
    
    var network: NetworkManager
    
    
    init() {
        network = NetworkManager()
        network.setupListener(self)
        
        for index in 1...64 {
            patch.append(Patch(objectNumber: index))
        }
    }
    
    
    func printPatch() {
        for p in patch {
            log.add(p.text)
        }
    }
    
   
    // MARK - Network
    
    func oscReceivedMessage(_ message: OscMessage) {
        DispatchQueue.main.async {
            self.log.add("\(message.address) \(message.getArguments())")
        }
    }
    
    func oscReceivedBundle(_ bundle: OscBundle) {
        
    }
    
    
    func listenerReceived(_ data: Data) {
        
    }
    
    
    func listenerReady() {
        print("listenerReady")
        network.setupClient()
        network.connectClient()
    }
    
    
    func sendMessage() {
        let message = OscMessage("/sending/to/max", [4])
        network.client?.send(message)
    }
}
