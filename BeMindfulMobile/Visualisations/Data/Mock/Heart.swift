//
//  Heart.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 22/10/2023.
//

import Foundation

extension HeartChartData {
    static var emptyMockHeart: HeartChartData {
        let hour: [Date: Int32] = [:]
        let day: [Date: Int32] = [:]

        let week: [Date: Int32] = [:]

        let month: [Date: Int32] = [:]
        return HeartChartData(hour: hour,
                             day: day,
                             week: week,
                             month: month)
    }

    static var mockHeart: HeartChartData {
        let hour: [Date: Int32] = [occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 0): 62,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 1): 64,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 2): 79,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 3): 72,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 4): 83,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 5): 78,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 6): 76,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 7): 81,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 8): 82,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 9): 103,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 10): 97,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 11): 115,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 12): 70,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 13): 75,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 14): 80,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 15): 70,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 16): 73,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 17): 76,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 18): 82,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 19): 75,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 20): 77,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 21): 75,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 22): 80,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 23): 85,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 24): 90,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 25): 95,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 26): 83,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 27): 84,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 28): 110,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 29): 86,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 30): 92,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 31): 91,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 32): 90,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 33): 79,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 34): 82,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 35): 78,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 36): 110,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 37): 119,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 38): 112,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 39): 122,
                                 occurrenceDate(year: 2023, month: 11, day: 29, hour: 14, minute: 40): 88]
        let day: [Date: Int32] = [occurrenceDate(year: 2023, month: 11, day: 29, hour: 8): 57,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 9): 68,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 10): 120,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 11): 73,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 12): 72,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 13): 75,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 14): 75,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 15): 76,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 16): 71,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 17): 73,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 18): 72,
                                occurrenceDate(year: 2023, month: 11, day: 29, hour: 19): 75]

        let week: [Date: Int32] = [occurrenceDate(year: 2023, month: 11, day: 27): 75,
                                 occurrenceDate(year: 2023, month: 11, day: 28): 76,
                                 occurrenceDate(year: 2023, month: 11, day: 29): 71]

        let month: [Date: Int32] = [occurrenceDate(year: 2023, month: 11, day: 1): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 2): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 3): 76,
                                  occurrenceDate(year: 2023, month: 11, day: 4): 71,
                                  occurrenceDate(year: 2023, month: 11, day: 5): 73,
                                  occurrenceDate(year: 2023, month: 11, day: 6): 72,
                                  occurrenceDate(year: 2023, month: 11, day: 7): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 8): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 9): 76,
                                  occurrenceDate(year: 2023, month: 11, day: 10): 71,
                                  occurrenceDate(year: 2023, month: 11, day: 11): 73,
                                  occurrenceDate(year: 2023, month: 11, day: 12): 72,
                                  occurrenceDate(year: 2023, month: 11, day: 13): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 14): 76,
                                  occurrenceDate(year: 2023, month: 11, day: 15): 71,
                                  occurrenceDate(year: 2023, month: 11, day: 16): 73,
                                  occurrenceDate(year: 2023, month: 11, day: 17): 72,
                                  occurrenceDate(year: 2023, month: 11, day: 18): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 19): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 20): 76,
                                  occurrenceDate(year: 2023, month: 11, day: 21): 71,
                                  occurrenceDate(year: 2023, month: 11, day: 22): 73,
                                  occurrenceDate(year: 2023, month: 11, day: 23): 72,
                                  occurrenceDate(year: 2023, month: 11, day: 24): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 25): 177,
                                  occurrenceDate(year: 2023, month: 11, day: 26): 73,
                                  occurrenceDate(year: 2023, month: 11, day: 27): 72,
                                  occurrenceDate(year: 2023, month: 11, day: 28): 75,
                                  occurrenceDate(year: 2023, month: 11, day: 29): 71]
        return HeartChartData(hour: hour,
                             day: day,
                             week: week,
                             month: month)
    }
    
    static func occurrenceDate(year: Int, month: Int, day: Int = 1, hour: Int = 7, minute: Int = 0) -> Date {

        Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
    }
}


