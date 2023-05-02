//
//  ChartDataContainer.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 01/05/2023.
//

import Foundation

class ChartDataContainer: ObservableObject {
    @Published var grouped: [(key: Date, value: Int)]

    init(grouped: [Date: Int] = [:]) {
        self.grouped = grouped.map { $0 }.sorted { $0.key < $1.key }
    }

    // TODO: fill up with mock data for preview
    static var preview: ChartDataContainer {
        return ChartDataContainer(grouped: LineChartData.preview.hourly)
    }
}
