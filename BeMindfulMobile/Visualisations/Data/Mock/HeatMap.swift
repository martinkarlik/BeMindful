//
//  HeatMap.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 15/11/2023.
//

import Foundation

extension HeatMapDataContainer {
    
    static var emptyMock: HeatMapDataContainer {
        return HeatMapDataContainer(heatmapData: [])
    }
    
    static var mock: HeatMapDataContainer {
        let heatmapData: [HeatmapCellData] = (1...31).map { day in
            HeatmapCellData(date: occurrenceDate(year: 2023, month: 11, day: day), count: Int.random(in: 0...100))
        }

        
        return HeatMapDataContainer(heatmapData: heatmapData)
    }
    
    static func occurrenceDate(year: Int, month: Int, day: Int = 1, hour: Int = 7, minute: Int = 0) -> Date {

        Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
    }
}
