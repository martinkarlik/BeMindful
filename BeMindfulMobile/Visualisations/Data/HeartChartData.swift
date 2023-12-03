//
//  HeartChartData.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 26/11/2023.
//

import Foundation

class HeartChartData: ObservableObject {
    let hourly: [Date: Int32]
    let daily: [Date: Int32]
    let weekly: [Date: Int32]
    let monthly: [Date: Int32]
    
    init(hour: [Date: Int32] = [:],
         day: [Date: Int32] = [:],
         week: [Date: Int32] = [:],
         month: [Date: Int32] = [:]) {
        self.hourly = hour
        self.daily = day
        self.weekly = week
        self.monthly = month
    }
    
}
