//
//  LineChartData.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 30/04/2023.
//

import Foundation

class LineChartData: ObservableObject {
    let hour: [Occurence]
    let day: [Occurence]
    let week: [Occurence]
    let month: [Occurence]

    init(hour: [Occurence] = [],
         day: [Occurence] = [],
         week: [Occurence] = [],
         month: [Occurence] = []) {
        self.hour = hour
        self.day = day
        self.week = week
        self.month = month
    }

    // TODO: fill up with mock data for previews
    static var preview: LineChartData {
        let hour: [Occurence] = []
        let day: [Occurence] = []
        let week: [Occurence] = []
        let month: [Occurence] = []
        return LineChartData(hour: hour,
                             day: day,
                             week: week,
                             month: month)
    }
}
