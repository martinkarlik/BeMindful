//
//  BitSpyApp.swift
//  BitSpy
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

@main
struct BitSpyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(session: WCSession.default)
        }
    }
}
