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
    
    init() {
        self.bfrbCounter = 0

    }
    
    func incrementCounter() {
        bfrbCounter += 1
    }
}
