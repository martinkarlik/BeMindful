//
//  TrendData.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 29/04/2023.
//

import Foundation

class TrendData: ObservableObject, Identifiable {
    let id: UUID
    let currentCount: Int
    let previousCount: Int

    init(current: Int, previous: Int) {
        self.id = UUID()
        self.currentCount = current
        self.previousCount = previous
    }
}