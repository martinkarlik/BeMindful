//
//  TrendDataContainer.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 01/05/2023.
//

import Foundation

class TrendDataContainer: ObservableObject {
    @Published var trendData: [TrendData]

    init(trendData: [TrendData] = []) {
        self.trendData = trendData
    }
}
