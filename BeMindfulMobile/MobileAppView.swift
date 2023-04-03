//
//  ContentView.swift
//  BitSpy
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

struct MobileAppView: View {

    @ObservedObject var viewModel = SharedViewModel()
    var connectivityProvider = ConnectivityProvider()
    
    var body: some View {
        VStack {
            Text("Nail bites: \(viewModel.bfrbCounter)")
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
        MobileAppView()
    }
}
