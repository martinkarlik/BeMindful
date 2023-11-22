//
//  HourlyLineChart.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import Charts
import SwiftUI

struct HeartRateGraph: View {
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
        }.reduce(0, +)) / Double(data.grouped.count)
        // Calculate the minimum and maximum dates from your data
        let minDate = data.grouped.map { $0.key }.min() ?? Date()
        let maxDate = data.grouped.map { $0.key }.max() ?? Date()
        let minCount = data.grouped.map { $0.value }.min() ?? 0
        let maxCount = data.grouped.map { $0.value }.max() ?? 10
        
        let hourBoundsForMinDate = BarChartData.getHourEdges(from: minDate)
        // Assuming maxDate is a Date value
        let xScaleDomain: [Date] = [hourBoundsForMinDate.start, hourBoundsForMinDate.end]
        
        
        let curColor = Color(.systemPink)
        let curGradient = LinearGradient(
            gradient: Gradient (
                colors: [
                    curColor.opacity(0.5),
                    curColor.opacity(0.2),
                    curColor.opacity(0.05),
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
        ZStack{
            
            Chart(data.grouped, id: \.key) { (date, count) in
                AreaMark(
                    x: .value("Day", date, unit: xComponent),
                    y: .value("Occurrences", count)
                )
                .foregroundStyle(curGradient)
                .symbol(.circle)
                
                RuleMark(
                    y: .value("Occurrences", dataAverage)
                )
                .foregroundStyle(.gray)
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [9, 2]))
                
            }
            .chartYAxis {
                AxisMarks(
                    values: [0, Double(minCount), dataAverage, Double(maxCount), Double(maxCount + 20)]
                )
            }
            .chartXScale(domain: xScaleDomain)
            .chartForegroundStyleScale([
                "Heart Rate": .pink,
                "Average": .gray
            ])
        }
        //        This modifier causes the crash, I'll leave it commented out for now
        //        .chartSymbolScale([
        //            "Nail Biting": Circle().strokeBorder(lineWidth: 2)
        //        ])
        
        .chartLegend(position: .top)
    }
}

struct HeartGraphDetails: View {
    @State private var timeRange: TimeRange = .lastHour
    @ObservedObject var data: BarChartData
    // @ObservedObject var timeRangeData: TimeRangePickerData
    
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
        VStack(alignment: .leading) {
            //                TimeRangePicker(value: $timeRange)
            //                    .padding(.bottom)
            
            Text("Heart Rate Data")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            HeartRateGraph(data: chartData, timeRange: timeRange)
                .frame(height: 240)
        }
    }
}

struct HeartGraphDetails_Previews: PreviewProvider {
    static var previews: some View {
        HeartGraphDetails(data: BarChartData.mockHeart)
    }
}

