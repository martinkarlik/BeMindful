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
    @Binding var timeRange: TimeRange

    var body: some View {
        let dataAverage = Double(data.grouped.map {
            $0.value
        }.reduce(0, +)) / Double(data.grouped.count)
        // Calculate the minimum and maximum dates from your data
        let minCount = data.grouped.map { $0.value }.min() ?? 0
        let maxCount = data.grouped.map { $0.value }.max() ?? 10

        // Assuming maxDate is a Date value
        let xComponent = Utils.getXComponent(for: timeRange)
        let xFormat = Utils.getXFormat(for: timeRange)
        let xScaleDomain = Utils.getXDomain(for: timeRange)
        let xValues = Utils.getXValues(for: timeRange)

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
            .chartXAxis {
                AxisMarks(format: xFormat, values: xValues)
            }
            .chartForegroundStyleScale([
                "Heart Rate": .pink,
                "Average": .gray
            ])
        }
        
        .chartLegend(position: .top)
    }
}

struct HeartGraphDetails: View {
    @ObservedObject var data: BarChartData
    @Binding var timeRange: TimeRange

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
            
            Text("Heart Rate Data")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            HeartRateGraph(data: chartData, timeRange: $timeRange)
                .frame(height: 240)
        }
    }
}

struct HeartGraphDetails_Previews: PreviewProvider {
    static var previews: some View {
        HeartGraphDetails(data: BarChartData.mockHeart, timeRange: .constant(.hour))
    }
}


