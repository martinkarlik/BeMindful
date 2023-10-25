//
//  CalendarHeatMap.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 25/10/2023.
//

import SwiftUI


struct CalendarHeatMap: View {
    @State var data: LineChartData
    let cellSize: CGFloat = 30 // Specific size for each cell

    var body: some View {
        VStack(alignment: .leading) {
            Text("Calendar")
                .font(.callout)
                .foregroundStyle(.secondary)

            VStack(alignment: .center) {
                // Display day of the week headers
                HStack {
                    ForEach(getDaysOfWeek(), id: \.self) { day in
                        Text(day)
                            .frame(width: cellSize, height: cellSize)
                            .font(.caption2)
                    }
                }

                ForEach(0..<6) { week in
                    HStack {
                        ForEach(0..<7) { day in
                            if let value = data.monthly[getMockDate(day: day)] {
                                CellView(value: value, getColor: self.getColor)
                            } else {
                                EmptyCellView()
                            }
                        }
                    }
                }
            }
        }
    }

    func getDaysOfWeek() -> [String] {
        // Get the first day of the current month
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month], from: Date())
        let firstDayOfMonth = calendar.date(from: dateComponents)
        
        // Create a dateFormatter to get the day of the week
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E" // This format will give you the day of the week like "SUN", "MON", etc.
        
        // Generate the days of the week
        var daysOfWeek = [String]()
        if let startDate = firstDayOfMonth {
            for i in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                    let dayOfWeek = dateFormatter.string(from: date)
                    daysOfWeek.append(dayOfWeek)
                }
            }
        }
        
        return daysOfWeek
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
    
    func getMockDate(day: Int) -> Date {
        // Calculate the date based on the day, month, and year
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 5 // May
        dateComponents.day = day

        // Calculate the week and weekday based on the day
        guard let date = calendar.date(from: dateComponents)
              else {
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

struct CellView: View {
    let value: Int
    let cellSize: CGFloat = 30
    let getColor: (Int) -> Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.green)
//                .fill(getColor(value))
                .frame(width: cellSize, height: cellSize)
            
            Text("\(value)")
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}

struct EmptyCellView: View {
    let cellSize: CGFloat = 30

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .frame(width: cellSize, height: cellSize)
    }
}

#Preview {
    CalendarHeatMap(data: LineChartData.mock)
}
