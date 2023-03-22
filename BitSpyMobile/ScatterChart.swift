//
//  ScatterChart.swift
//  BitSpyMobile
//
//  Created by Vivien Varadi on 22/03/2023.
//

import Foundation
import SwiftUI
import Charts

struct ScatterChart: View {

    var data: [Data] = [
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 3, hour: 16, minute: 40)) ?? Date()),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 3, hour: 16, minute: 50)) ?? Date()),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 3, hour: 17, minute: 20)) ?? Date())
    ]
    var body: some View {
        Chart {
            ForEach(data) { data in
                PointMark(
                    x: .value("Date", data.date),
                    y: .value("Time", data.date)
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 12)) { value in
                if let date = value.as(Date.self) {
                    let hour = Calendar.current.component(.hour, from: date)
                    switch hour {
                    case 0, 12:
                        AxisValueLabel(format: .dateTime.hour())
                    default:
                        AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .omitted)))
                    }
                    
                    AxisGridLine()
                    AxisTick()
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: .stride(by: .minute, count: 12)) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel(format: .dateTime.minute())
                    AxisGridLine()
                    AxisTick()
                }
            }
        }
    }
}
