//
//  NetworkExtensions.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/26/23.
//

import Foundation
import Network



extension NWListener: NWListenerProtocol {}

protocol NWListenerProtocol {
    var port: NWEndpoint.Port? { get }
    var stateUpdateHandler: ((_ newState: NWListener.State) -> Void)? { get set }
    var newConnectionHandler: ((_ connection: NWConnection) -> Void)? { get set }
    
    func cancel()
    func start(queue: DispatchQueue)
}



extension NWConnection: NWConnectionProtocol {}

protocol NWConnectionProtocol {
    var stateUpdateHandler: ((_ state: NWConnection.State) -> Void)? { get set }
    
    func receiveMessage(completion: @escaping (_ completeContent: Data?, _ contentContext: NWConnection.ContentContext?, _ isComplete: Bool, _ error: NWError?) -> Void)
}
