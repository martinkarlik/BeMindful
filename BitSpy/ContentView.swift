//
//  ContentView.swift
//  BitSpy
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    
    var session: WCSession
    
    @ObservedObject var trackerModel = TrackerViewModel()
    
    var body: some View {
        VStack {
            Text("Nail bites: " + trackerModel.bitCounter.codingKey.stringValue)
        }
        .onAppear {
            if WCSession.isSupported() {
//                session.delegate = self
                session.activate()
            }
        }
        .padding()
    }
    
    func sendMessageToWatch() {
        if session.isReachable {
            let message = ["key": "value"]
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(session: WCSession.default)
    }
}

//extension ContentView: WCSessionDelegate {
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        // Handle session activation completion
//    }
//
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        print("Message received")
//        // Handle incoming message from the Apple Watch
//    }
//}
