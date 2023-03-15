//
//  BitSpyApp.swift
//  BitSpy Watch App
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

@main
struct BitSpy_Watch_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(session: WCSession.default)
        }
    }
}
