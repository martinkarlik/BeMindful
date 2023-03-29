//
//  SwiftUIView.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import SwiftUI

func occurrenceDate(year: Int, month: Int, day: Int = 1, hour: Int = 7, minute: Int = 0) -> Date {
    
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
}

// Data for the occurrences by location and weekday charts.
struct BFRBData {
    /// A data series for the lines.
    struct Series: Identifiable {
        /// The name of the BFRB.
        let BFRBName: String

        /// Average daily occurrences for each weekday.
        /// The `weekday` property is a `Date` that represents a weekday.
        let occurrences: [(weekday: Date, occurrences: Int)]

        /// The identifier for the series.
        var id: String { BFRBName }
    }

    /// occurrences by location and weekday for the last 30 days.
    /// change it to timestamps - remove occurrences
    static let lastHour: [Series] = [
        .init(BFRBName: "Nail Biting", occurrences: [
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 8),  occurrences: 1),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 10), occurrences: 1),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 14), occurrences: 1),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 22), occurrences: 1),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 34), occurrences: 1),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2, hour: 8, minute: 43), occurrences: 1),
        ])
    ]

    /// The best weekday and location for the last 30 days.
    static let lastHourMost = (
        BFRBName: "Nail Biting",
        weekday: occurrenceDate(year: 2022, month: 5, day: 8, hour: 8, minute: 8),
        occurrences: 1
    )


    /// occurrences by location and weekday for the last 12 months.
    static let lastDay: [Series] = [
        .init(BFRBName: "Nail Biting", occurrences: [
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2), occurrences: 40),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 3), occurrences: 30),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 4), occurrences: 6),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 5), occurrences: 10),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 6), occurrences: 13),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 7), occurrences: 22),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 8), occurrences: 44),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2), occurrences: 6),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 3), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 4), occurrences: 33),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 5), occurrences: 30),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 6), occurrences: 29),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 7), occurrences: 15),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 8), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 3), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 4), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 5), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 6), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 7), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 8), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 3), occurrences: 0),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 4), occurrences: 0)
        ])
    ]
    
    
    /// The best weekday and location for the last 12 months.
    static let lastDayMost = (
        BFRBName: "Nail Biting",
        weekday: occurrenceDate(year: 2022, month: 5, day: 8),
        occurrences: 113
    )
    
    /// occurrences by location and weekday for the last 12 months.
    static let lastWeek: [Series] = [
        .init(BFRBName: "Nail Biting", occurrences: [
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2), occurrences: 57),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 3), occurrences: 56),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 4), occurrences: 66),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 5), occurrences: 61),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 6), occurrences: 60),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 7), occurrences: 77),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 8), occurrences: 113)
        ])
    ]
    
    
    /// The best weekday and location for the last 12 months.
    static let lastWeekMost = (
        BFRBName: "Nail Biting",
        weekday: occurrenceDate(year: 2022, month: 5, day: 8),
        occurrences: 113
    )
    
    /// occurrences by location and weekday for the last 12 months.
    static let lastMonth: [Series] = [
        .init(BFRBName: "Nail Biting", occurrences: [
            (weekday: occurrenceDate(year: 2022, month: 5, day: 2), occurrences: 57),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 3), occurrences: 56),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 4), occurrences: 66),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 5), occurrences: 61),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 6), occurrences: 60),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 7), occurrences: 77),
            (weekday: occurrenceDate(year: 2022, month: 5, day: 8), occurrences: 113)
        ])
    ]
    
    
    /// The best weekday and location for the last 12 months.
    static let lastMonthMost = (
        BFRBName: "Nail Biting",
        weekday: occurrenceDate(year: 2022, month: 5, day: 8),
        occurrences: 113
    )
}


