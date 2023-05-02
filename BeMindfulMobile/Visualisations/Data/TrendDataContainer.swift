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

    static var preview: TrendDataContainer {
        return TrendDataContainer(trendData: [TrendData(current: 5, previous: 3),
                                              TrendData(current: 24, previous: 30),
                                              TrendData(current: 128, previous: 100)]
        )
    }
}
