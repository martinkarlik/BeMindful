//
//  ConnectionProvider.swift
//  BeMindful
//
//  Created by Martin Karlik on 22/03/2023.
//

import Foundation
import WatchConnectivity

class ConnectivityProvider: NSObject {
    
    var session: WCSession
    var occurenceViewModel: OccurenceViewModel?
    
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
            // Communication from iphone to watch is not established
            session.sendMessage([:], replyHandler: nil, errorHandler: nil)
        }
    }
    
    func sendMessageToiPhone() {
        if session.isReachable {
            let message = ["timestamp": Date()]
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    func sendHeartRateToiPhone() {
        if session.isReachable {
            let message: [String: Any] = ["timestamp": Date(), "bpm": Int32()]
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
        session.delegate = nil
    }
    #endif
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activated")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {

        guard let viewModel = occurenceViewModel else {
            return
        }
        
        
        if let bpm = message["bpm"] as? Int32,
           let timestamp = message["timestamp"] as? Date {
            DispatchQueue.main.async {
                viewModel.addHeartRate(heartRateTimestamp: timestamp, bpm: bpm)
            }
            
        } else if let timestamp = message["timestamp"] as? Date {
            DispatchQueue.main.async {
                viewModel.addOccurence(occurenceTimestamp: timestamp)
            }
        }

    }
}
