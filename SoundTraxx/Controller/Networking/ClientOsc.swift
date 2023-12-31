//
//  ClientOsc.swift
//  SoundTraxx
//
//  Created by GW Rodriguez on 11/1/23.
//

import Foundation
import Network





class ClientOsc {
    private var _client: NWConnection?
    private var _address: NWEndpoint.Host = "127.0.0.1"
    private var _port: NWEndpoint.Port = 1234
    private let _queue = DispatchQueue(label: "SoundTraxx ClientOsc")
    
    
    init() {}
    
    
    init?(connect withAddress: NWEndpoint.Host, to port: NWEndpoint.Port) {
        connect(to: withAddress, with: port)
        if _client == nil {return nil}
    }
    
    
    deinit {
        disconnect()
    }
    
    
    
    
    
    //MARK: - Connections
    func connect() {
        connect(to: _address, with: _port)
    }
    
    
    func connect(to address: NWEndpoint.Host, with port: NWEndpoint.Port) {
        _address = address
        _port = port
        
        disconnect()
        let params = NWParameters.udp
        params.allowLocalEndpointReuse = true
        _client = NWConnection(host: address, port: _port, using: params)
        
        _client!.stateUpdateHandler = { newState in
            switch newState {
            case .preparing:
                print("Entered state: preparing")
            case .ready:
                print("Entered state: ready")
            case .setup:
                print("Entered state: setup")
            case .cancelled:
                print("Entered state: cancelled")
            case .waiting:
                print("Entered state: waiting")
            case .failed:
                print("Entered state: failed")
            default:
                print("Entered an unknown state")
            }
        }
        
        _client!.start(queue: _queue)
    }
    
    
    func disconnect() {
        _client?.cancel()
        _client = nil
    }
    
    
    
    
    
    //MARK - Endpoints
    func address() -> String {
        return _address.debugDescription
    }
    
    
    func port() -> Int {
        return Int(_port.rawValue)
    }
    
    
    func setEndpoints(address: String, port: Int) {
        setAddress(address)
        setPort(port)
    }
    
    
    func setAddress(_ address: String) {
        _address = NWEndpoint.Host(address)
    }
    
    
    func setPort(_ port: Int) {
        _port = NWEndpoint.Port(rawValue: UInt16(port))!
    }
    
    
    
    
    
    //MARK - Sending
    func send(_ element: OscElement) {
        _client?.send(content: element.data, completion: .contentProcessed({ error in
            if error != nil {
                print("ClientOsc.send() error: \(String(describing: error))")
            }
            else {
                print("Message sent")
            }
        }))
    }
    
    
    
    
    
    //MARK - Query
    func isConnected() -> Bool {
        return _client != nil
    }
}
