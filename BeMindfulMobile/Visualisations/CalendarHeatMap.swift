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
                    ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                        Text(day)
                            .frame(width: cellSize, height: cellSize)
                            .font(.caption2)
                    }
                }
                
                ForEach(0..<5) { week in
                    HStack {
                        ForEach(0..<7) { day in
                            if let value = data.monthly[getDate(week: week, day: day)] {
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

struct CellView: View {
    let value: Int
    let cellSize: CGFloat = 30
    let getColor: (Int) -> Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(getColor(value))
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
