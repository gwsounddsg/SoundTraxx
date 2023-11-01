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
    func listenerReady()
}





class Listener {
    let delegate: ListenerDelegate?
    let port: Int
    
    internal var _listener: NWListenerProtocol?
    internal var _connection: NWConnectionProtocol?
    
    private let _queue: DispatchQueue
    
    init(_ port: Int, _ queueName: String, delegate: ListenerDelegate?) {
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
                self.delegate?.listenerReceived(newData)
            }
            
            self.receive() // loop
        })
    }
    
    
    
    
    
    //MARK: - Connection
    
    func connect() throws {
        try createNewListener()
        
        if _listener == nil {
            print("Listener is nil, quitting connection")
            return
        }
        
        setupStateHandler()
        setupConnectionHandler()
        
        _listener!.start(queue: _queue)
        
        print("Started Listening to port: \(port) on queue: \(_queue.label)")
    }
    
    
    internal func createNewListener() throws {
        _listener?.cancel()
        
        let endpoint = NWEndpoint.Port(String(port))!
        
        let parameters = NWParameters.udp
        parameters.allowLocalEndpointReuse = true
        let newListener = try NWListener(using: parameters, on: endpoint)
        
        _listener = newListener
    }
    
    
    private func setupStateHandler() {
        _listener?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Listening on port \(String(describing: self.port)) is now ready")
                self.delegate!.listenerReady()
            case .failed(let error):
                print("Listener failed with error \(error)")
            default:
                print("Unhandled state for listener: \(state)")
            }
        }
    }
    
    
    private func setupConnectionHandler() {
        _listener?.newConnectionHandler = { connection in
            self.createConnection(connection)
            self.receive()
            self._connection?.start(queue: self._queue)
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
