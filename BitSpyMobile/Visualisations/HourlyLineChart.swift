//
//  HourlyLineChart.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import Charts
import SwiftUI

struct HourlyLineChart: View {
    let data: [BFRBData.Series]
    let mostOccurrences: (BFRBName: String, weekday: Date, occurrences: Int)
    
    var body: some View {
        Chart(data) { series in
            ForEach(series.occurrences, id: \.weekday) { element in
                LineMark(
                    x: .value("Day", element.weekday, unit: .day),
                    y: .value("occurrences", element.occurrences)
                )
            }
            .foregroundStyle(by: .value("Habit", series.BFRBName))
            .symbol(by: .value("Habit", series.BFRBName))
            .interpolationMethod(.catmullRom)
        }
        .chartForegroundStyleScale([
            "Nail Biting": .purple
        ])
        .chartSymbolScale([
            "Nail Biting": Circle().strokeBorder(lineWidth: 2)
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
            }
        }

        .chartLegend(position: .top)
    }
}

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

struct LineChartDetails_Previews: PreviewProvider {
    static var previews: some View {
        LineChartDetails()
    }
}


