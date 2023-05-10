//
//  HistoryDataContainer.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 09/05/2023.
//

import Foundation

class HistoryDataContainer: ObservableObject {
    @Published var historyData: [HistoryData]

    init(historyData: [HistoryData] = []) {
        self.historyData = historyData
    }
}
