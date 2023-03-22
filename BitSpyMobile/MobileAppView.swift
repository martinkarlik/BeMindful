//
//  ContentView.swift
//  BitSpy
//
//  Created by Martin Karlik on 08/03/2023.
//

import SwiftUI
import WatchConnectivity

struct MobileAppView: View {
    
    @State var counter: Int = 0
    
    @State var viewModel = SharedViewModel()
    
    var body: some View {
        VStack {
            Text("Nail bites: \(counter)")
            
            Button("Click", action: {
                counter += 1
            })

            ScatterChart()
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MobileAppView()
    }
}
