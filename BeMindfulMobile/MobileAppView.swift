//
//  ContentView.swift
//  BitSpy
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

struct MobileAppView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var occurences: FetchedResults<Occurence>
    
    @ObservedObject var viewModel = SharedViewModel()
    var connectivityProvider = ConnectivityProvider()
    
    var body: some View {
        VStack {
            List(occurences) { occurence in
                Text(occurence.timestamp ?? "Unknown")
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
        MobileAppView()
    }
}
