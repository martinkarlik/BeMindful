//
//  ContentView.swift
//  BitSpy
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

// We should think it over and restructure the app once
struct MobileAppView: View {
    // We'll be able to remove this as well when we get rid of the list
    @ObservedObject var viewModel = OccurenceViewModel()
    var connectivityProvider = ConnectivityProvider()
    
    @State private var showCheckmark = false
    
    var body: some View {
        VStack {
            List(viewModel.occurences) { occurence in
                Text(formatDate(occurence.timestamp) ?? "Unknown")
            }
            CheckMarkView() {
                viewModel.addOccurence(occurenceTimestamp: Date())
            }
        }
        .onAppear {
            connectivityProvider.occurenceViewModel = viewModel
            connectivityProvider.connect()
        }
        .padding()
    }
    
}

extension MobileAppView {
    
    func formatDate(_ date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MobileAppView()
    }
}
