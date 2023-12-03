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
                    connectivityProvider.occurenceViewModel?.startObservingHeartRateChanges()
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
            
            
            if healthKitManager.isAuthorized() {
                print("Heart rate authorized")
                connectivityProvider.occurenceViewModel?.startObservingHeartRateChanges()
                
            } else {
                // Request health authorization.
                requestAuthorization()
            }
            // cll timer if fail
        }
        .padding()
    }

    func recordLiveHeartRate()-> Int32? {
        // HealthKit is already authorized, proceed with recording live heart rate data.
        var bpm: Int32?
        healthKitManager.startObservingHeartRateChanges { result in
            switch result {
            case .success(let heartRate):
                // Heart rate recorded successfully
                bpm = Int32(heartRate)
                connectivityProvider.occurenceViewModel?.addHeartRate(heartRateTimestamp: Date(), bpm: bpm ?? 0)
                self.connectivityProvider.sendHeartRateToiPhone(bpm: bpm ?? 0)
                print("Heart rate recorded successfully: \(String(describing: bpm)) BPM")

                
                // Handle the recorded heart rate as needed
                // For example, you might update your UI or store the data.

            case .failure(let error):
                // Handle the error
                print("Error recording heart rate: \(error.localizedDescription)")
                bpm = nil
            }
        }
        return bpm
    }
    
    
    func requestAuthorization() {
        healthKitManager.requestAuthorization { result in
            switch result {
            case .success(let success):
                if success {
                    self.recordLiveHeartRate()
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
    
    func timer() {
        // Schedule the recordLiveHeartRate function to be called every 30 seconds
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            // Check if HealthKit is authorized before recording heart rate
            if healthKitManager.isAuthorized() {
                // this should save the bpm
                if let bpm = recordLiveHeartRate() {
                    // and pass it here
                    connectivityProvider.sendHeartRateToiPhone(bpm: bpm)
                }

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
