//
//  LineChartData.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 30/04/2023.
//

import Foundation

class LineChartData: ObservableObject, Identifiable {
    let hourly: [Date: Int]
    let daily: [Date: Int]
    let weekly: [Date: Int]
    let monthly: [Date: Int]

    init(hour: [Date: Int] = [:],
         day: [Date: Int] = [:],
         week: [Date: Int] = [:],
         month: [Date: Int] = [:]) {
        self.hourly = hour
        self.daily = day
        self.weekly = week
        self.monthly = month
    }

    // TODO: fill up with mock data for previews
    static var preview: LineChartData {
        let hour: [Date: Int] = [:]
        let day: [Date: Int] = [:]
        let week: [Date: Int] = [:]
        let month: [Date: Int] = [:]
        return LineChartData(hour: hour,
                             day: day,
                             week: week,
                             month: month)
    }
}
