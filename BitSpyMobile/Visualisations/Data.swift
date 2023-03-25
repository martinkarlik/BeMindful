//
//  SwiftUIView.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import SwiftUI

func occurenceDate(year: Int, month: Int, day: Int = 1, hour: Int = 1) -> Date {
    
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour)) ?? Date()
}

// Data for the occurrencies by location and weekday charts.
struct BFRBData {
    /// A data series for the lines.
    struct Series: Identifiable {
        /// The name of the BFRB.
        let BFRBName: String

        /// Average daily occurrencies for each weekday.
        /// The `weekday` property is a `Date` that represents a weekday.
        let occurrencies: [(weekday: Date, occurrencies: Int)]

        /// The identifier for the series.
        var id: String { BFRBName }
    }

    /// occurrencies by location and weekday for the last 30 days.
    /// change it to timestamps - remove occurrencies
    static let lastHour: [Series] = [
        .init(BFRBName: "Nail Biting", occurrencies: [
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 4),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 3),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 2),
            (weekday: occurenceDate(year: 2022, month: 5, day: 5), occurrencies: 3),
            (weekday: occurenceDate(year: 2022, month: 5, day: 6), occurrencies: 1),
            (weekday: occurenceDate(year: 2022, month: 5, day: 7), occurrencies: 5),
        ])
    ]

    /// The best weekday and location for the last 30 days.
    static let lastHourMost = (
        BFRBName: "Nail Biting",
        weekday: occurenceDate(year: 2022, month: 5, day: 8),
        occurrencies: 5
    )


    /// occurrencies by location and weekday for the last 12 months.
    static let lastDay: [Series] = [
        .init(BFRBName: "Nail Biting", occurrencies: [
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 40),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 30),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 6),
            (weekday: occurenceDate(year: 2022, month: 5, day: 5), occurrencies: 10),
            (weekday: occurenceDate(year: 2022, month: 5, day: 6), occurrencies: 13),
            (weekday: occurenceDate(year: 2022, month: 5, day: 7), occurrencies: 22),
            (weekday: occurenceDate(year: 2022, month: 5, day: 8), occurrencies: 44),
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 6),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 33),
            (weekday: occurenceDate(year: 2022, month: 5, day: 5), occurrencies: 30),
            (weekday: occurenceDate(year: 2022, month: 5, day: 6), occurrencies: 29),
            (weekday: occurenceDate(year: 2022, month: 5, day: 7), occurrencies: 15),
            (weekday: occurenceDate(year: 2022, month: 5, day: 8), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 5), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 6), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 7), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 8), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 0),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 0)
        ])
    ]
    
    
    /// The best weekday and location for the last 12 months.
    static let lastDayMost = (
        BFRBName: "Nail Biting",
        weekday: occurenceDate(year: 2022, month: 5, day: 8),
        occurrencies: 113
    )
    
    /// occurrencies by location and weekday for the last 12 months.
    static let lastWeek: [Series] = [
        .init(BFRBName: "Nail Biting", occurrencies: [
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 57),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 56),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 66),
            (weekday: occurenceDate(year: 2022, month: 5, day: 5), occurrencies: 61),
            (weekday: occurenceDate(year: 2022, month: 5, day: 6), occurrencies: 60),
            (weekday: occurenceDate(year: 2022, month: 5, day: 7), occurrencies: 77),
            (weekday: occurenceDate(year: 2022, month: 5, day: 8), occurrencies: 113)
        ])
    ]
    
    
    /// The best weekday and location for the last 12 months.
    static let lastWeekMost = (
        BFRBName: "Nail Biting",
        weekday: occurenceDate(year: 2022, month: 5, day: 8),
        occurrencies: 113
    )
    
    /// occurrencies by location and weekday for the last 12 months.
    static let lastMonth: [Series] = [
        .init(BFRBName: "Nail Biting", occurrencies: [
            (weekday: occurenceDate(year: 2022, month: 5, day: 2), occurrencies: 57),
            (weekday: occurenceDate(year: 2022, month: 5, day: 3), occurrencies: 56),
            (weekday: occurenceDate(year: 2022, month: 5, day: 4), occurrencies: 66),
            (weekday: occurenceDate(year: 2022, month: 5, day: 5), occurrencies: 61),
            (weekday: occurenceDate(year: 2022, month: 5, day: 6), occurrencies: 60),
            (weekday: occurenceDate(year: 2022, month: 5, day: 7), occurrencies: 77),
            (weekday: occurenceDate(year: 2022, month: 5, day: 8), occurrencies: 113)
        ])
    ]
    
    
    /// The best weekday and location for the last 12 months.
    static let lastMonthMost = (
        BFRBName: "Nail Biting",
        weekday: occurenceDate(year: 2022, month: 5, day: 8),
        occurrencies: 113
    )
}


