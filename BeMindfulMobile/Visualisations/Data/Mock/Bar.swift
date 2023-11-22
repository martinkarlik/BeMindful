//
//  LineChart.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 09/05/2023.
//

import Foundation

extension BarChartData {
    static var emptyMock: BarChartData {
        let hour: [Date: Int] = [:]
        let day: [Date: Int] = [:]

        let week: [Date: Int] = [:]

        let month: [Date: Int] = [:]
        return BarChartData(hour: hour,
                             day: day,
                             week: week,
                             month: month)
    }

    static var mock: BarChartData {
        let hour: [Date: Int] = [occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 8): 5,
                                 occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 10): 6,
                                 occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 14): 1,
                                 occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 22): 3,
                                 occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 34): 2,
                                 occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 43): 5]
        let day: [Date: Int] = [occurrenceDate(year: 2022, month: 5, day: 2, hour: 8): 5,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 9): 6,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 10): 1,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 11): 3,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 12): 2,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 13): 5,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 14): 5,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 15): 6,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 16): 1,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 17): 3,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 18): 2,
                                occurrenceDate(year: 2022, month: 5, day: 2, hour: 19): 5]

        let week: [Date: Int] = [occurrenceDate(year: 2022, month: 5, day: 2): 5,
                                 occurrenceDate(year: 2022, month: 5, day: 3): 6,
                                 occurrenceDate(year: 2022, month: 5, day: 4): 1,
                                 occurrenceDate(year: 2022, month: 5, day: 5): 3,
                                 occurrenceDate(year: 2022, month: 5, day: 6): 2,
                                 occurrenceDate(year: 2022, month: 5, day: 7): 5]

        let month: [Date: Int] = [occurrenceDate(year: 2022, month: 5, day: 1): 0,
                                  occurrenceDate(year: 2022, month: 5, day: 2): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 3): 6,
                                  occurrenceDate(year: 2022, month: 5, day: 4): 1,
                                  occurrenceDate(year: 2022, month: 5, day: 5): 3,
                                  occurrenceDate(year: 2022, month: 5, day: 6): 2,
                                  occurrenceDate(year: 2022, month: 5, day: 7): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 8): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 9): 6,
                                  occurrenceDate(year: 2022, month: 5, day: 10): 1,
                                  occurrenceDate(year: 2022, month: 5, day: 11): 3,
                                  occurrenceDate(year: 2022, month: 5, day: 12): 2,
                                  occurrenceDate(year: 2022, month: 5, day: 13): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 14): 6,
                                  occurrenceDate(year: 2022, month: 5, day: 15): 1,
                                  occurrenceDate(year: 2022, month: 5, day: 16): 3,
                                  occurrenceDate(year: 2022, month: 5, day: 17): 2,
                                  occurrenceDate(year: 2022, month: 5, day: 18): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 19): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 20): 6,
                                  occurrenceDate(year: 2022, month: 5, day: 21): 1,
                                  occurrenceDate(year: 2022, month: 5, day: 22): 3,
                                  occurrenceDate(year: 2022, month: 5, day: 23): 2,
                                  occurrenceDate(year: 2022, month: 5, day: 24): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 25): 1,
                                  occurrenceDate(year: 2022, month: 5, day: 26): 3,
                                  occurrenceDate(year: 2022, month: 5, day: 27): 2,
                                  occurrenceDate(year: 2022, month: 5, day: 28): 5,
                                  occurrenceDate(year: 2022, month: 5, day: 29): 1,
                                  occurrenceDate(year: 2022, month: 5, day: 30): 3,
                                  occurrenceDate(year: 2022, month: 5, day: 31): 2]
        return BarChartData(hour: hour,
                             day: day,
                             week: week,
                             month: month)
    }

    static func occurrenceDate(year: Int, month: Int, day: Int = 1, hour: Int = 7, minute: Int = 0) -> Date {

        Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
    }
}