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
                    ForEach(getDaysOfWeekStartingFromMonday(), id: \.self) { day in
                        Text(day)
                            .frame(width: cellSize, height: cellSize)
                            .font(.caption2)
                    }
                }
                ForEach(0..<5) { week in
                    HStack {
                        ForEach(0..<7) { day in
                            let weekday = week * 7 + day
                            let date = getDate(week: week, day: day)
                            // add month data from real data
                            // if let value = data.heatmapData
                            CellView(weekday: weekday, value: day, getColor: self.getColor)

                        }
                    }
                }
//                ForEach(0..<6) { week in
//                    HStack {
//                        ForEach(0..<7) { day in
//                            let weekday = week * 7 + day
//                            let date = getDate(week: week, day: day)
//                            
//                            if let value = data.monthly.findValue(at: date, toGranularity: .day) {
//                                CellView(weekday: weekday, value: value, getColor: self.getColor)
//                                

//                            if let startOfMonth = Date() {
//                                if date < startOfMonth {
//                                    // Displays empty cell for days before the start of the month
//                                    EmptyCellView()
//                                } else {
                                    // Displays cell with color and date for days on or after the start of the month
                                    
                                        
//                                    } else {
//                                        EmptyCellView()
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
            }
        }
    }
    
    func getMonthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func getDaysOfWeekStartingFromMonday() -> [String] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        // Find the current date
        let currentDate = Date()
        
        // Find the first day of the current week (Sunday)
        if let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) {
            
            // Generate an array of days starting from Monday
            var daysOfWeek = [String]()
            for i in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: i, to: sunday) {
                    let dayOfWeek = dateFormatter.string(from: date)
                    daysOfWeek.append(dayOfWeek)
                }
            }
            
            return daysOfWeek
        } else {
            return []
        }
    }
    
    
    func getDate(week: Int, day: Int) -> Date {
        // Gets the current calendar
        let calendar = Calendar.current

        // Get the current date components
        var currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())

        // Get the first day of the month
        guard let firstDayOfMonth = calendar.date(from: currentDateComponents) else {
            // Error handling
            print("Error getting first day of month")
            return Date()
        }

        // Calculate the date for the given week and day
        currentDateComponents.weekOfMonth = week
        currentDateComponents.weekday = day

        guard let date = calendar.date(bySetting: .day, value: currentDateComponents.day ?? 1, of: firstDayOfMonth) else {
            // Error handling
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
        let maxValue = 10
        
        // Clamp the value between 0 and maxValue
        let clampedValue = min(max(value, 0), maxValue)
        
        // Calculate the intensity of the red color
        let intensity = Double(clampedValue) / Double(maxValue)
        
        // Return a color from white to red based on the intensity
        return Color(red: 1 + intensity, green: 0.8 - intensity, blue: 0.4 - intensity)
    }
    
}

struct CellView: View {
    let weekday: Int
    let value: Int
    let cellSize: CGFloat = 30
    let getColor: (Int) -> Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
            //.fill(Color.green)
                .fill(getColor(value))
                .frame(width: cellSize, height: cellSize)
            
            Text("\(weekday)")
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
