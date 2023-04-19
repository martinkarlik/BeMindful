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
    
    var connectivityProvider = ConnectivityProvider()
    var motionDetectionProvider = MotionDetectionProvider()
    
    @State private var showCheckmark = false
    
    var body: some View {
        VStack {
            Text("Oops! I did it again.")
            CheckMarkView() {
                connectivityProvider.sendMessageToiPhone()
            }
        }
        .onAppear {
            connectivityProvider.connect()
            
            if Constants.gestureDetection {
                motionDetectionProvider.monitorRotationRate()
            }
        }
        .padding()
    }
    
}


extension WatchAppView {
    enum Constants {
        static let gestureDetection = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchAppView()
    }
}
