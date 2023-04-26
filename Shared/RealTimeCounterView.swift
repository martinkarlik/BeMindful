//
//  RealTimeCounterView.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 26/04/2023.
//

import SwiftUI

struct RealTimeCounter: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Behavior statistics:")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color("DarkPurple"))
            HStack(spacing: 16) {
                CounterView(count: "4",
                            title: "Last hour",
                            arrowDirection: "down",
                            arrowColor: .green)
                CounterDivider()
                CounterView(count: "6", title: "Last day",
                            arrowDirection: "up",
                            arrowColor: .red)
                CounterDivider()
                CounterView(count: "15", title: "Last week",
                            arrowDirection: "down",
                            arrowColor: .green)
            }
        }
    }
}

struct CounterDivider: View {
    var body: some View {
        Divider()
            .frame(width: 5, height: 80, alignment: .center)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

struct CounterView: View {
    let count: String
    let title: String
    let arrowDirection: String
    let arrowColor: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            VStack(alignment: .center, spacing: 1) {
                Text(count)
                    .font(.system(size: 28, weight: .semibold))
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Image(systemName: "arrow.\(arrowDirection)")
                .foregroundColor(arrowColor)
        }
        .padding()
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


struct RealTimeCounterView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeCounter()
    }
}
