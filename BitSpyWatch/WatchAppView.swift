//
//  ContentView.swift
//  BitSpy Watch App
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import Combine
import WatchConnectivity

struct WatchAppView: View {
    
    @ObservedObject var viewModel = SharedViewModel()
    var connectivityProvider = ConnectivityProvider()
    
    var body: some View {
        VStack {
            Button("Oops I did it again!") {
                connectivityProvider.sendMessageToiPhone()
            }
        }
        .onAppear {
            connectivityProvider.connect()
            connectivityProvider.sharedViewModel = viewModel
        }
        .padding()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchAppView()
    }
}
