//
//  BeMindfulApp.swift
//  BeMindful
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

@main
struct BeMindfulMobileApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            OnboardingView(logoImage: "LaunchIcon")
//            MobileAppView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
