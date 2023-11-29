//
//  HourlyLineChart.swift
//  BitSpyMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//

import Charts
import SwiftUI

struct HeartRateGraph: View {

    @ObservedObject var data: HeartDataContainer
    @Binding var timeRange: TimeRange
    
    var body: some View {
        let dataAverage = Double(data.grouped.map {
            $0.value
        }.reduce(0, +)) / Double(data.grouped.count)
        // Calculate the minimum and maximum dates from your data
        let minHeartRate = data.grouped.map { $0.value }.min() ?? 0
        let maxHeartRate = data.grouped.map { $0.value }.max() ?? 10

        // Assuming maxDate is a Date value
        let xComponent = Utils.getXComponent(for: timeRange)
        let xFormat = Utils.getXFormat(for: timeRange)
        let xScaleDomain = Utils.getXDomain(for: timeRange)
        let xValues = Utils.getXValues(for: timeRange)
        let yDomain = [0, maxHeartRate + 24]

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
                        //change count with something else
                        y: .value("HeartRate", count)
                    )
                    .foregroundStyle(curGradient)
                    .symbol(.circle)
                    
                    RuleMark(
                        y: .value("HeartRate", dataAverage)
                    )
                    .foregroundStyle(.gray)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [9, 2]))
                    
                }
                .chartYScale(domain: yDomain, type: .linear)
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

struct HeartRateStatsView: View {
    @ObservedObject var data: HeartDataContainer

    var body: some View {
        let dataAverage: Double = {
            if data.grouped.count != 0 {
                return Double(data.grouped.map { $0.value }.reduce(0, +)) / Double(data.grouped.count)
            } else {
                return 0
            }
        }()
        // Calculate the minimum and maximum dates from your data
        let minHeartRate = data.grouped.map { $0.value }.min() ?? 0
        let maxHeartRate = data.grouped.map { $0.value }.max() ?? 0
        
        HStack(alignment: .center, spacing: 1) {
            Spacer()
            StatView(title: "Min", value: minHeartRate)
            Spacer()
            CounterDivider()
            Spacer()
            StatView(title: "Average", value: Int32(dataAverage))
            Spacer()
            CounterDivider()
            Spacer()
            StatView(title: "Max", value: maxHeartRate)
            Spacer()
        }
        .padding()
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct StatView: View {
    let title: String
    let value: Int32

    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            Text("\(value)")
                .font(.system(size: 28, weight: .semibold))
            Text("\(title)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct HeartGraphDetails: View {

    @ObservedObject var data: HeartChartData
    @Binding var timeRange: TimeRange

    var chartData: HeartDataContainer {
        switch timeRange {
        case .hour:
            return HeartDataContainer(grouped: data.hourly)
        case .day:
            return HeartDataContainer(grouped: data.daily)
        case .week:
            return HeartDataContainer(grouped: data.weekly)
        case .month:
            return HeartDataContainer(grouped: data.monthly)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Heart Rate Data")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            HeartRateGraph(data: chartData, timeRange: $timeRange)
                .frame(height: 240)
            //Stats
            HeartRateStatsView(data: chartData)
        }
        
        
        
    }
}

struct HeartGraphDetails_Previews: PreviewProvider {
    static var previews: some View {
        HeartGraphDetails(data: HeartChartData.mockHeart, timeRange: .constant(.hour))

    }
}


