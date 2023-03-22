//
//  TrackerViewModel.swift
//  BitSpy
//
//  Created by Martin Karlik on 12/03/2023.
//

import Foundation
import Combine
import SwiftUI

class SharedViewModel: ObservableObject {
    
    @Published var bfrbCounter: Int
    var connectivityProvider = ConnectivityProvider()
    
    init(bfrbCounter: Int = 0) {
        self.bfrbCounter = bfrbCounter
    }
    
    func sendMessageToiPhone() {
        connectivityProvider.sendMessageToiPhone()
    }
    
    func sendMessageToWatch() {
        connectivityProvider.sendMessageToWatch()
    }
}
