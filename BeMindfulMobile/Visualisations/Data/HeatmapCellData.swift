//
//  HeatmapData.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 15/11/2023.
//

import Foundation

class HeatmapCellData: ObservableObject, Identifiable {
    let date: Date
    let count: Int

    init(date: Date, count: Int) {
        self.date = date
        self.count = count
    }
}
