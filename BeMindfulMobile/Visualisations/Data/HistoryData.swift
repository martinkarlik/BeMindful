//
//  HistoryData.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 09/05/2023.
//

import Foundation

class HistoryData: ObservableObject, Identifiable {
    let date: Date
    let count: Int
    let timeInterval: String

    init(date: Date, count: Int, timeInterval: String) {
        self.date = date
        self.count = count
        self.timeInterval = timeInterval
    }
}
