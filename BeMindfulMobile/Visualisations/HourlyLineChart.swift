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


struct LineChartDetails_Previews: PreviewProvider {
    static var previews: some View {
        HourlyLineChart(data: [], mostOccurrences: ("", Date(), 0))
    }
}


