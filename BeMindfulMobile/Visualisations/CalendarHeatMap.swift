//
//  CalendarHeatMap.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 25/10/2023.
//

import SwiftUI


struct CalendarHeatMap: View {
    @State var data: HeatMapDataContainer
    let cellSize: CGFloat = 30
    
    var body: some View {
        let currentDate = Date()
        let calendar = Calendar.current
        let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: currentDate)
        let numberOfWeeks = weekRange?.count ?? 0

        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("Calendar")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                Text(getMonthName(from: currentDate))
                    .font(.callout)
                    .foregroundStyle(.secondary)
                HStack{
                    HStack {
                        EmptyCellView(getColor: Color(red: 1 + 0, green: 0.8 - 0, blue: 0.4 - 0))
                        Text("Less")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    Text("")
                    HStack {
                        EmptyCellView(getColor: Color(red: 1, green: 0.8 - 1, blue: 0.4 - 1))
                        Text("Many")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            VStack(alignment: .center) {
                // Displays day of the week headers
                HStack {
                    ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                        Text(day)
                            .frame(width: cellSize, height: cellSize)
                            .font(.caption2)
                    }
                }
                ForEach(1..<numberOfWeeks + 1) { week in
                    HStack {
                        ForEach(1..<8) { day in
                            let date = getDate(week: week, day: day)
                            // If we have a value for it in the data, we display it
                            if let value = data.heatmapData.first(where: { calendar.isDate($0.date, inSameDayAs: date) }) {
                                CellView(value: value.count, getColor: self.getColor)
                            } else {
                                EmptyCellView()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getMonthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func getDate(week: Int, day: Int) -> Date {
        let calendar = Calendar.current

        // Get the first day of the current month
        var components = calendar.dateComponents([.year, .month], from: Date())
        guard let firstDayOfMonth = calendar.date(from: components) else {
            print("Error getting first day of month")
            return Date()
        }

        // Find the first day of the week in the month
        components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: firstDayOfMonth)
        guard let firstWeekDayOfMonth = calendar.date(from: components) else {
            print("Error getting first week day of month")
            return Date()
        }

        // Calculate the target date by adding (week - 1) weeks and (day - 1) days
        // Note: day is 1-based (1 for Sunday, 2 for Monday, ..., 7 for Saturday)
        let targetDate = calendar.date(byAdding: .day, value: ((week - 1) * 7) + (day - 2), to: firstWeekDayOfMonth)!
        return targetDate
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
        return Color(red: 1 + intensity, green: 0.8 - intensity, blue: 0.4 - intensity)
    }
    
}

struct CellView: View {
    let value: Int
    let cellSize: CGFloat = 30
    let getColor: (Int) -> Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
            //.fill(Color.green)
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
    let getColor: Color?
    
    init(getColor: Color? = nil) {
        self.getColor = getColor
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(getColor ?? Color.gray)
            .opacity(0.3)
            .frame(width: cellSize, height: cellSize)
    }
}

#Preview {
    CalendarHeatMap(data: HeatMapDataContainer.mock)
}
