//
//  ContentView.swift
//  BitSpy Watch App
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity
import CoreMotion

struct WatchAppView: View {
    
    var healthKitManager = HealthKitManager()
    var connectivityProvider = ConnectivityProvider()
    var motionDetectionProvider = MotionDetectionProvider()
    
    var body: some View {
        VStack {
            Text("Oops! I did it again.")
            CheckMarkView() {
                connectivityProvider.sendMessageToiPhone()
                
                if healthKitManager.isAuthorized() {
                    print("Heart rate authorized")
                    recordLiveHeartRate()
                    
                } else {
                    // Request health authorization.
                    requestAuthorization()
                }
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
    
    func recordLiveHeartRate() {
        // HealthKit is already authorized, proceed with recording live heart rate data.
        healthKitManager.recordLiveHeartRate { result in
            switch result {
            case .success(let heartRate):
                // Heart rate recorded successfully
                print("Heart rate recorded successfully: \(heartRate) BPM")

                // Handle the recorded heart rate as needed
                // For example, you might update your UI or store the data.

            case .failure(let error):
                // Handle the error
                print("Error recording heart rate: \(error.localizedDescription)")
            }
        }
    }
    
    
    func requestAuthorization() {
        healthKitManager.requestAuthorization { result in
            switch result {
            case .success(let success):
                if success {
                    recordLiveHeartRate()
                } else {
                    // Authorization denied
                    print("Authorization denied")
                }
                
            case .failure(let error):
                // Handle the error
                print("Authorization error: \(error.localizedDescription)")
            }
        }
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
