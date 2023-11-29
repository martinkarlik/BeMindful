//
//  HeartDataContainer.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 22/11/2023.
//

import HealthKit

// include timestamp and BPM
class HeartDataContainer: ObservableObject {
    @Published var grouped: [(key: Date, value: Int32)]

    init(grouped: [Date: Int32] = [:]) {
        self.grouped = grouped.map { $0 }.sorted { $0.key < $1.key }
    }
}

extension HeartDataContainer {
    static var mock: HeartDataContainer {
        return HeartDataContainer(grouped: HeartChartData.mockHeart.hourly)
    }
}
