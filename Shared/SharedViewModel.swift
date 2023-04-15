//
//  TrackerViewModel.swift
//  BeMindful
//
//  Created by Martin Karlik on 12/03/2023.
//

import Foundation
import Combine
import SwiftUI

class SharedViewModel: ObservableObject {
    
    @Published var bfrbCounter: Int
    @Published var bfrbOccurences: [String]
    let defaults = UserDefaults.standard
    
    init() {
        self.bfrbCounter = defaults.integer(forKey: "bfrbCounter")
        self.bfrbOccurences = []
    }
    
    func incrementCounter() {
        bfrbCounter += 1
        defaults.set(bfrbCounter, forKey:"bfrbCounter")
    }
    
    func addBfrbOccurence(occurenceTimestamp: String) {
        bfrbOccurences.append(occurenceTimestamp)
        bfrbCounter += 10
        print(occurenceTimestamp)
    }
}
