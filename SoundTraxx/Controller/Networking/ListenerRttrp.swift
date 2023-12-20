//
//  ListenerRttrpm.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 12/20/23.
//

import Foundation



protocol ListenerRttrpDelegate: AnyObject, ListenerDelegate {
    func receivedRttrp(_ rttrp: RTTrP)
}





class ListenerRttrp: Listener {
    weak var delegateRttrpm: ListenerRttrpDelegate?
    
    
    override func receive() {
        _connection?.receiveMessage(completion: { completeContent, contentContext, isComplete, error in
            if self.delegateRttrpm == nil {return}
            
            if error != nil {
                print("ListenerRttrpm receive error: \(String(describing: error))")
                return
            }
            
            if let newData = completeContent {
                self.sendToDelegate(newData)
            }
            
            self.receive() // loop
        })
    }
}





// MARK - Relaying
internal extension ListenerRttrp {
    func sendToDelegate(_ data: Data) {
        do {
            let rttrp = try RTTrP(data: data.bytes)
            delegateRttrpm?.receivedRttrp(rttrp)
        }
        catch {
            print("Error converting data to RTTrP: \(String(describing: error))")
        }
    }
}
