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
    let defaults = UserDefaults.standard
    
    init() {
        self.bfrbCounter = defaults.integer(forKey: "bfrbCounter")

    }
    
    func incrementCounter() {
        bfrbCounter += 1
        defaults.set(bfrbCounter, forKey:"bfrbCounter")
    }
}
