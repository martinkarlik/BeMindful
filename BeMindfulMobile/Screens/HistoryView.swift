//
//  HistoryView.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 26/04/2023.
//

import SwiftUI

struct Occurrence: Identifiable {
    let id = UUID()
    let times: Int
    let timeSlot: String
}

struct HistoryView: View {
    @ObservedObject var data: HistoryDataContainer
    @State private var isShowingCalendarPicker = false
    @State private var selectedDate = Date()
    let selectedBehavior: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("History")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("DarkPurple"))
                    Spacer()
                    Button(action: { isShowingCalendarPicker.toggle() }) {
                        Image(systemName: "calendar")
                    }
                    .font(.title2)
                    .foregroundColor(Color("DarkPurple"))
                }
                Text("Your behavior history per hour")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Text("Selected date:")
                    Text("\(selectedDate, formatter: dateFormatter)")
                        .fontWeight(.semibold)
                }
                Divider()
                List(data.historyData) { rowData in
                    HStack {
                        Text("\(rowData.count) times")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(rowData.timeInterval)
                    }
                }
                Spacer()
                Divider()
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .navigationBarHidden(true)
            .onChange(of: selectedDate) { _ in isShowingCalendarPicker.toggle() }
            
            if isShowingCalendarPicker {
                CalendarPickerView(selectedDate: $selectedDate)
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

extension Date {
    func stripTime() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components)!
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(data: HistoryDataContainer.mock, selectedBehavior: "nail biting")
    }
}
