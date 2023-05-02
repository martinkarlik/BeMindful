//
//  Graphs.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 02/05/2023.
//

import SwiftUI

struct LineChartDetails: View {
    @State private var timeRange: TimeRange = .lastHour

    var mostOccurrences: (BFRBName: String, weekday: Date, occurrences: Int) {
        switch timeRange {
        case .lastHour:
            return BFRBData.lastHourMost
        case .lastDay:
            return BFRBData.lastDayMost
        case .lastWeek:
            return BFRBData.lastWeekMost
        case .lastMonth:
            return BFRBData.lastMonthMost
        }
    }

    var data: [BFRBData.Series] {
        switch timeRange {
        case .lastHour:
            return BFRBData.lastHour
        case .lastDay:
            return BFRBData.lastDay
        case .lastWeek:
            return BFRBData.lastWeek
        case .lastMonth:
            return BFRBData.lastMonth
        }
    }

    var descriptionText: Text {
        let occurrences = mostOccurrences.occurrences.formatted(.number)
        let weekday = mostOccurrences.weekday.formatted(.dateTime.weekday(.wide))
        let BFRBName = mostOccurrences.BFRBName
        let time: String
        switch timeRange {
        case .lastHour:
            time = "last hour"
        case .lastDay:
            time = "last 24 hours"
        case .lastWeek:
            time = "last week"
        case .lastMonth:
            time = "last month"
        }
        return Text("On average, \(occurrences) occurencies of \(BFRBName) were counted in the \(time). on \(weekday)s ")
    }

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)

                Text("Habit occurrences")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                Text("Nail biting occurrences")
                    .font(.title2.bold())

                HourlyLineChart(data: data, mostOccurrences: mostOccurrences)
                    .frame(height: 240)

                descriptionText
                    .font(.subheadline)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitle("Habit over time", displayMode: .inline)
    }
}


struct Graphs_Previews: PreviewProvider {
    static var previews: some View {
        LineChartDetails()
    }
}
