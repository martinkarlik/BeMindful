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
    
    @ObservedObject var viewModel = MobileAppViewModel()
    var connectivityProvider = ConnectivityProvider()
    
    @State private var showCheckmark = false
    
    var body: some View {
        VStack {
            List(occurences) { occurence in
                Text(formatDate(occurence.timestamp) ?? "Unknown")
            }
            Button(action: {
                viewModel.addBfrbOccurence(occurenceTimestamp: Date())
                
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
        }
        .onAppear {
            viewModel.moc = moc
            connectivityProvider.mobileAppViewModel = viewModel
            connectivityProvider.connect()
        }
        .padding()
    }
    
}

extension MobileAppView {
    enum Constants {
        static let buttonDiamater = 80.0
        static let animationTime = 1.0
        static let gestureDetection = false
    }
    
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
