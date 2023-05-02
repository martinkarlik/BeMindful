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
    
    var body: some View {
        Chart(data.occurences) { occurence in
            LineMark(
                x: .value("Day", occurence.timestamp, unit: .day),
                y: .value("occurrences", occurence.timestamp)
            )
            .foregroundStyle(by: .value("Habit", "Nail biting"))
            .symbol(by: .value("Habit", "Nail biting"))
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



struct HourlyLineChart_Previews: PreviewProvider {
    static var previews: some View {
        HourlyLineChart(data: ChartDataContainer.preview)
    }
}


