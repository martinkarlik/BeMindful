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
    
    @ObservedObject var viewModel = OccurenceViewModel()
    var connectivityProvider = ConnectivityProvider()
    
    @State private var showCheckmark = false
    
    var body: some View {
        VStack {
            List(occurences) { occurence in
                Text(formatDate(occurence.timestamp) ?? "Unknown")
            }
            CheckMarkView() {
                viewModel.addBfrbOccurence(occurenceTimestamp: Date())
            }
        }
        .onAppear {
            viewModel.moc = moc
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
