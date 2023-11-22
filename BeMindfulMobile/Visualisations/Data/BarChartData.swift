//
//  LineChartData.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 30/04/2023.
//

import Foundation

class BarChartData: ObservableObject {
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

    static func getHourEdges(from date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        var startComponent = DateComponents()
        startComponent.minute = 0
        var endComponent = DateComponents()
        endComponent.minute = 59

        guard let startOfHour = calendar.nextDate(after: date, matching: startComponent, matchingPolicy: .nextTime, direction: .backward),
              let endOfHour = calendar.nextDate(after: date, matching: endComponent, matchingPolicy: .nextTime)
        else {
            print("Error getting hour edges")
            return (Date(), Date())
        }

        return (startOfHour, endOfHour)
    }
}
