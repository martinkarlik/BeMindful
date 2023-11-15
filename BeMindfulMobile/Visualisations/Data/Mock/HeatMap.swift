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
        
        return HeatMapDataContainer(heatmapData: [HeatmapCellData(date: occurrenceDate(year: 2022, month: 5, day: 1), count: 5),
                                                  HeatmapCellData(date: occurrenceDate(year: 2022, month: 5, day: 2), count: 0)])
    }
    
    static func occurrenceDate(year: Int, month: Int, day: Int = 1, hour: Int = 7, minute: Int = 0) -> Date {

        Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
    }
}
