//
//  ConnectionProvider.swift
//  BitSpy
//
//  Created by Martin Karlik on 22/03/2023.
//

import Foundation
import WatchConnectivity

class ConnectivityProvider: NSObject {
    
    var session: WCSession
    
    override init() {
        self.session = WCSession.default
    }
    
    func connect() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    func sendMessageToWatch() {
        if session.isReachable {
            let message = ["key": "value"]
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    func sendMessageToiPhone() {
        if session.isReachable {
            let message = ["key": "value"]
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    
}

extension ConnectivityProvider: WCSessionDelegate {
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session deactivated")
    }
    #endif
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activated")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Message received")
    }
}
