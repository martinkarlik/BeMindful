//
//  HourlyLineChart.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import Charts
import SwiftUI

struct BarChart: View {
    @ObservedObject var data: ChartDataContainer
    let selectedBehavior: String
    @Binding var timeRange: TimeRange
    
    var body: some View {
        
        let dataAverage = Double(data.grouped.map {
            $0.value
        }.reduce(0, +)) / Double(data.grouped.count)
        let maxCount = data.grouped.map { $0.value }.max() ?? 10

        let xComponent = Utils.getXComponent(for: timeRange)
        let xFormat = Utils.getXFormat(for: timeRange)
        let xScaleDomain = Utils.getXDomain(for: timeRange)
        let xValues = Utils.getXValues(for: timeRange)
        let yDomain = [0, maxCount + 1]

        ZStack{
            
            Chart(data.grouped, id: \.key) { (date, count) in
                BarMark(
                    x: .value("Day", date, unit: xComponent),
                    y: .value("Occurrences", count)
                )
                .foregroundStyle(.purple)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                .symbol(.circle)
                
                .interpolationMethod(.catmullRom)
                .opacity(0.8)
                
                RuleMark(
                    y: .value("Occurrences", dataAverage)
                )
                .foregroundStyle(.yellow)
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [9, 2]))
            }
            .chartYScale(domain: yDomain, type: .linear)
            // Use xScaleDomain in chartXScale
            .chartXScale(domain: xScaleDomain)
            .chartXAxis {
                AxisMarks(format: xFormat, values: xValues)
            }
            .chartForegroundStyleScale([
                selectedBehavior: .purple,
                "Average": .yellow
            ])
            
        }
        .chartLegend(position: .top)
    }
}

struct BarChartDetails: View {
    @ObservedObject var data: BarChartData
    @Binding var timeRange: TimeRange
    let selectedBehavior: String

    var chartData: ChartDataContainer {
        switch timeRange {
        case .hour:
            return ChartDataContainer(grouped: data.hourly)
        case .day:
            return ChartDataContainer(grouped: data.daily)
        case .week:
            return ChartDataContainer(grouped: data.weekly)
        case .month:
            return ChartDataContainer(grouped: data.monthly)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Habit occurrences")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Text("\(selectedBehavior) occurrences")
                .font(.title2.bold())
            
            BarChart(data: chartData, selectedBehavior: selectedBehavior, timeRange: $timeRange)
                .frame(height: 240)
        }
    }
}

struct BarChartDetails_Previews: PreviewProvider {
    static var previews: some View {
        BarChartDetails(data: BarChartData.mock, timeRange: .constant(.hour), selectedBehavior: "Nail biting")
    }
}


