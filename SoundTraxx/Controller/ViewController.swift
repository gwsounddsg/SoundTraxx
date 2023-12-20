//
//  ViewController.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import SwiftUI


class ViewController: ObservableObject, ListenerOscDelegate, ListenerRttrpDelegate {
    @Published var log = Log()
    @Published var patch: [Patch] = []
    @Published var edit: Bool = false
    
    var network: NetworkManager
    var currentTrackables = [String: Int]()
    
    
    init() {
        network = NetworkManager()
        network.setupListenerOsc(self)
        network.setupListenerRttrpm(self)
        
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
        network.setupClient()
        network.connectClient()
    }
    
    
    func receivedRttrp(_ rttrp: RTTrP) {
        let pmPackets = rttrp.pmPackets
        
        for packet in pmPackets {
            guard let trackable = packet.trackable else {continue}
            guard let centroid = trackable.submodules[.centroidAccVel] as? [CentroidAccVel] else {continue}
            
            if centroid.isEmpty {continue}
            
            let x = Float(centroid[0].position.x)
            let y = Float(centroid[0].position.y)
            
            DispatchQueue.main.async {
                let str = String(format: "RTTrP Trackable \(trackable.name) x: %.2f y: %.2f", x, y)
                self.log.add(str)
            }
        }
    }
    
    
    func sendMessage() {
        let message = OscMessage("/sending/to/max", [4])
        network.client?.send(message)
    }
}
