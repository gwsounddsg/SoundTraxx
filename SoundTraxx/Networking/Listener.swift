//
//  Listener.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 10/26/23.
//

import Foundation
import Network





protocol ListenerDelegate {
    func listenerReceived(_ data: Data)
}





class Listener {
    let delegate: ListenerDelegate
    let port: Int
    
    internal var _listener: NWListenerProtocol?
    internal var _connection: NWConnectionProtocol?
    
    private let _queue: DispatchQueue
    
    init(_ port: Int, _ queueName: String, delegate: ListenerDelegate) {
        self.port = port
        _queue = DispatchQueue(label: queueName)
        self.delegate = delegate
    }
    
    
    deinit {
        _listener?.cancel()
    }
    
    
    func receive() {
        _connection?.receiveMessage(completion: { completeContent, contentContext, isComplete, error in
            if error != nil {
                print("Listener receive error: \(String(describing: error))")
                return
            }
            
            if let newData = completeContent {
                self.delegate.listenerReceived(newData)
            }
            
            self.receive() // loop
        })
    }
    
    
    
    
    
    //MARK: - Connection
    
    func connect() throws {
        try createNewListener()
        
        setupStateHandler()
        setupConnectionHandler()
        _listener!.start(queue: _queue)
        
        print("Started Listening to port: \(port) on queue: \(_queue.label)")
    }
    
    
    internal func createNewListener() throws {
        _listener?.cancel()
        
        let endpoint = NWEndpoint.Port(String(port))!
        let newListener = try NWListener(using: .udp, on: endpoint)
        
        _listener = newListener
    }
    
    
    private func setupStateHandler() {
        _listener?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Listening on port \(String(describing: self.port))")
            case .failed(let error):
                print("Listener failed with error \(error)")
            default:
                print("Unhandled state for listener: \(state)")
            }
        }
    }
    
    
    private func setupConnectionHandler() {
        _listener?.newConnectionHandler = { [weak self] connection in
            guard let strongSelf = self else {
                print("Error: weak self in Listener")
                return
            }
            
            connection.start(queue: strongSelf._queue)
            strongSelf.createConnection(connection)
        }
    }
    
    
    private func createConnection(_ connection: NWConnection) {
        _connection = connection
        _connection!.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Listener ready to receive message: \(connection)")
                self.receive()
            default:
                print("Create connection state: \(state)")
            }
        }
    }
}
