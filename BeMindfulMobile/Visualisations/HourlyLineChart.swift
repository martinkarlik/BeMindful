//
//  HourlyLineChart.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import Charts
import SwiftUI

struct HourlyLineChart: View {
    @ObservedObject var data: ChartDataContainer
    var timeRange: TimeRange
    
    var xComponent: Calendar.Component {
        switch timeRange {
        case .lastHour:
            return .minute
        case .lastDay:
            return .hour
        case .lastWeek:
            return .weekday
        case .lastMonth:
            return .day
        }
    }
    
    var xFormat: Date.FormatStyle {
        switch timeRange {
        case .lastHour:
            return .dateTime.minute()
        case .lastDay:
            return .dateTime.hour()
        case .lastWeek:
            return .dateTime.weekday(.abbreviated)
        case .lastMonth:
            return .dateTime.day()
        }
    }

    var body: some View {
        let dataAverage = Double(data.grouped.map {
            $0.value
        }.reduce(data.grouped.first?.value ?? 0, +)) / Double(data.grouped.count)
        // Calculate the minimum and maximum dates from your data
        let minDate = data.grouped.map { $0.key }.min() ?? Date()
        let maxDate = data.grouped.map { $0.key }.max() ?? Date()
        let minCount = data.grouped.map { $0.value }.min() ?? 0
        let maxCount = data.grouped.map { $0.value }.max() ?? 10
        
        ZStack{
            
            Chart(data.grouped, id: \.key) { (date, count) in
                BarMark(
                    x: .value("Day", date, unit: xComponent),
                    y: .value("Occurrences", count)
                )
                .foregroundStyle(.purple)
                .symbol(.circle)
                .symbol(by: .value("Habit", "Nail biting"))
                .interpolationMethod(.catmullRom)
                .opacity(0.6)
                
                LineMark(
                    x: .value("Day", date, unit: xComponent),
                    y: .value("Occurrences", dataAverage)
                )
                .foregroundStyle(.yellow)
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [9, 2]))
                .interpolationMethod(.catmullRom)
                
            }
            .chartForegroundStyleScale([
                "Nail Biting": .purple
            ])
            .chartYAxis {
                AxisMarks(
                    values: [0, Double(minCount), dataAverage, Double(maxCount), Double(maxCount + 2)]
                )
            }
            
            
        }
//        This modifier causes the crash, I'll leave it commented out for now
//        .chartSymbolScale([
//            "Nail Biting": Circle().strokeBorder(lineWidth: 2)
//        ])

        .chartLegend(position: .top)
    }
}

struct LineChartDetails: View {
    @State private var timeRange: TimeRange = .lastHour
    @ObservedObject var data: LineChartData
    
    var chartData: ChartDataContainer {
        switch timeRange {
        case .lastHour:
            return ChartDataContainer(grouped: data.hourly)
        case .lastDay:
            return ChartDataContainer(grouped: data.daily)
        case .lastWeek:
            return ChartDataContainer(grouped: data.weekly)
        case .lastMonth:
            return ChartDataContainer(grouped: data.monthly)
        }
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
                
                HourlyLineChart(data: chartData, timeRange: timeRange)
                    .frame(height: 240)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitle("Habit over time", displayMode: .inline)
    }
}

struct LineChartDetails_Previews: PreviewProvider {
    static var previews: some View {
        LineChartDetails(data: LineChartData.mock)
    }
}


