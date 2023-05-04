//
//  CalendarPickerView.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 01/05/2023.
//

import SwiftUI

struct CalendarPickerView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        DatePicker(
            "",
            selection: $selectedDate,
            displayedComponents: [.date]
            
        )
        .padding()
        .datePickerStyle(.graphical)
        .frame(width: 300, height: 300)
        .clipped()
        .background(Color("PopUp"))
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct CalendarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPickerView(selectedDate: .constant(Date()))
    }
}
