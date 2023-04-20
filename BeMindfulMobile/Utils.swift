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
