//
//  HistoryView().swift
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
    @State private var isShowingCalendarPicker = false
    @State private var selectedDate = Date()
    let selectedBehavior: String
    
    var occurrences: [Occurrence] {
        [ Occurrence(times: 3, timeSlot: "9:00 - 10:00"),
          Occurrence(times: 2, timeSlot: "10:00 - 11:00"),
          Occurrence(times: 4, timeSlot: "11:00 - 12:00"),
          Occurrence(times: 1, timeSlot: "12:00 - 13:00"),
          Occurrence(times: 1, timeSlot: "13:00 - 14:00"),
          Occurrence(times: 1, timeSlot: "14:00 - 15:00"),
          Occurrence(times: 1, timeSlot: "15:00 - 16:00"),]
    }
    var occurences2: [Occurrence] {
        [ Occurrence(times: 2, timeSlot: "10:00 - 11:00"),
          Occurrence(times: 4, timeSlot: "11:00 - 12:00"),
          Occurrence(times: 2, timeSlot: "13:00 - 14:00"),
          Occurrence(times: 1, timeSlot: "18:00 - 19:00"),]
    }
    
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
                if selectedDate.stripTime() == Date().stripTime() {
                    List(occurrences) { occurrence in
                        HStack {
                            Text("\(occurrence.times) times")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(occurrence.timeSlot)
                        }
                    }
                } else {
                    List(occurences2) { occurrence in
                        HStack {
                            Text("\(occurrence.times) times")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(occurrence.timeSlot)
                        }
                    }
                }
                Spacer()
                Divider()
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .navigationBarHidden(true)
            
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
        HistoryView(selectedBehavior: "nail biting")
    }
}
