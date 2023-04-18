//
//  ContentView.swift
//  BitSpy Watch App
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import Combine
import WatchConnectivity
import CoreMotion

struct WatchAppView: View {
    
    @ObservedObject var viewModel = SharedViewModel()
    var connectivityProvider = ConnectivityProvider()
    var motionDetectionProvider = MotionDetectionProvider()
    
    var body: some View {
        VStack {
            Button("Oops I did it again!") {
                connectivityProvider.sendMessageToiPhone()
            }
        }
        .onAppear {
            connectivityProvider.connect()
            connectivityProvider.sharedViewModel = viewModel
            motionDetectionProvider.monitorRotationRate()
        }
        .padding()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchAppView()
    }
}
