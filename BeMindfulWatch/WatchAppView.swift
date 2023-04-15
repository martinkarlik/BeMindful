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
            Button(action: {
                connectivityProvider.sendMessageToiPhone()
                
                withAnimation {
                    self.showCheckmark = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTime) {
                    withAnimation {
                        self.showCheckmark = false
                    }
                }
            }) {
                if !showCheckmark {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .frame(width: Constants.buttonDiamater, height: Constants.buttonDiamater)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: Constants.buttonDiamater, height: Constants.buttonDiamater)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
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
        static let buttonDiamater = 80.0
        static let animationTime = 1.0
        static let gestureDetection = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchAppView()
    }
}
