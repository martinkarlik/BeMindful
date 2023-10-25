//
//  CalendarHeatMap.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 25/10/2023.
//

import SwiftUI


struct CalendarHeatMap: View {
        @State var data: LineChartData

        var body: some View {
            VStack(alignment: .leading) {
                ForEach(0..<5) { week in
                    HStack {
                        ForEach(0..<7) { day in
                            if let value = data.monthly[getDate(week: week, day: day)] {
                                Rectangle()
                                    .fill(getColor(value: value))
                            } else {
                                Rectangle()
                                    .fill(Color.gray)
                            }
                        }
                    }
                }
            }
        }
    
    

    func getDate(week: Int, day: Int) -> Date {
        // Get the first day of the current month
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        guard let firstDayOfMonth = calendar.date(from: components) else {
            // Handle this error in a way that makes sense for your app
            print("Error getting first day of month")
            return Date()
        }

        // Calculate the date for the given week and day
        var dateComponents = DateComponents()
        dateComponents.weekOfMonth = week
        dateComponents.weekday = day

        guard let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) else {
            // Handle this error in a way that makes sense for your app
            print("Error calculating date")
            return Date()
        }

        return date
    }


    func getColor(value: Int) -> Color {
        // Define the maximum value that corresponds to full red
        let maxValue = 100

        // Clamp the value between 0 and maxValue
        let clampedValue = min(max(value, 0), maxValue)

        // Calculate the intensity of the red color
        let intensity = Double(clampedValue) / Double(maxValue)

        // Return a color from white to red based on the intensity
        return Color(red: intensity, green: 1.0 - intensity, blue: 1.0 - intensity)
    }

}

#Preview {
    CalendarHeatMap(data: LineChartData.mock)
}
