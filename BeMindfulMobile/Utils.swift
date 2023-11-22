//
//  Utils.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import SwiftUI

enum TimeRange {
    case lastHour
    case lastDay
    case lastWeek
    case lastMonth
}

struct Utils {
    static func round(value: Double, decimalPlaces: Int = 0) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return Darwin.round(value * multiplier) / multiplier
    }

    static func formatDate(date: Date, to format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}


struct TimeRangePicker: View {
    @Binding var value: TimeRange

    var body: some View {
        Picker("Time Range", selection: $value.animation(.easeInOut)) {
            Text("Hour").tag(TimeRange.lastHour)
            Text("Day").tag(TimeRange.lastDay)
            Text("Week").tag(TimeRange.lastWeek)
            Text("Month").tag(TimeRange.lastMonth)
        }
        .pickerStyle(.segmented)
    }
}

enum TrackedBehavior: String, CaseIterable {
    case behavior1 = "Nail Picking"
    case behavior2 = "Nail Biting"
    case behavior3 = "Cheek Biting"
    case behavior4 = "Hair Pulling"
    case behavior5 = "Other..."
}

extension Dictionary where Key == Date, Value == Int {
    func findValue(at date: Date, toGranularity component: Calendar.Component) -> Int? {
        let calendar = Calendar.current
        for (key, value) in self {
            if calendar.isDate(key, equalTo: date, toGranularity: component) {
                return value
            }
        }
        return nil
    }
}
