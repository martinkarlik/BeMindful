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
          Occurrence(times: 1, timeSlot: "12:00 - 1:00"),]
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("History")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: { isShowingCalendarPicker.toggle() }) {
                        Image(systemName: "calendar")
                    }
                    .font(.title2)
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
                List(occurrences) { occurrence in
                    HStack {
                        Text("\(occurrence.times) times")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(occurrence.timeSlot)
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
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: geometry.size.width, height: geometry.size.height / 3)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                    .background(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowingCalendarPicker = false
                    }
                }
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





struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(selectedBehavior: "nail biting")
    }
}
