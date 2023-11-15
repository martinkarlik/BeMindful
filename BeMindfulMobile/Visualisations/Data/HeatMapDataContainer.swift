//
//  HeatMapDataContainer.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 15/11/2023.
//

import Foundation

class HeatMapDataContainer: ObservableObject {
    @Published var heatmapData: [HeatmapCellData]

    init(heatmapData: [HeatmapCellData] = []) {
        self.heatmapData = heatmapData
    }
}
