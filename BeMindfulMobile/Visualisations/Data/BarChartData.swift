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
}
