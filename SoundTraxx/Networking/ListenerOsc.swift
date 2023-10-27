//
//  ListenerOsc.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/27/23.
//

import Foundation



protocol ListenerOscDelegate: AnyObject {
    func oscReceivedMessage(_ message: OscMessage)
    func oscReceivedBundle(_ bundle: OscBundle)
}





class ListenerOsc: Listener {
    weak var delegateOsc: ListenerOscDelegate?
    
    
    override func receive() {
        _connection?.receiveMessage(completion: { completeContent, contentContext, isComplete, error in
            if self.delegateOsc == nil {return}
            if error != nil {
                print("ListenerOsc receive error: \(String(describing: error))")
                return
            }
            
            if let newData = completeContent {
                self.sendToDelegate(newData)
                return
            }
            
            self.receive() // loop
        })
    }
}





// MARK: Relaying
private extension ListenerOsc {
    func sendToDelegate(_ data: Data) {
        let forwardSlash = 0x2f
        
        if data[0] == forwardSlash  { sendMessage(data) }
        else                        { sendBundle(data) }
    }
    
    
    func sendMessage(_ data: Data) {
        do {
            let message = try OscParseMessage(data)
            delegateOsc?.oscReceivedMessage(message)
        }
        catch {
            print("Error parsing osc packet: \(error)")
        }
    }
    
    
    func sendBundle(_ data: Data) {
        do {
            let bundle = try OscParseBundle(data)
            delegateOsc?.oscReceivedBundle(bundle)
        }
        catch {
            print("Error parsing osc bundle: \(error)")
        }
    }
}
