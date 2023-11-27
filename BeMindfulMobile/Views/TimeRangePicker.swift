//
//  TimeRangePicker.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 22/11/2023.
//

import SwiftUI

enum TimeRange: String, CaseIterable {
    case hour
    case day
    case week
    case month
}

struct TimeRangePicker: View {
    @Binding var value: TimeRange

    var body: some View {
        Picker("Time Range", selection: $value.animation(.easeInOut)) {
            ForEach(TimeRange.allCases, id: \.self) { component in
                Text(component.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
    }
}
