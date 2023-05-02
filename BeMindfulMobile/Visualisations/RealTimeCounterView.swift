//
//  RealTimeCounterView.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 26/04/2023.
//

import SwiftUI

struct RealTimeCounter: View {
    @ObservedObject var data: TrendDataContainer

    var body: some View {
        VStack(alignment: .leading){
            Text("Behavior overview:")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color("DarkPurple"))
            HStack(spacing: 8) {
            CounterView(data: data.trendData[0],
                        title: "Last hour")
            CounterDivider()
            CounterView(data: data.trendData[1],
                        title: "Last day")
            CounterDivider()
            CounterView(data: data.trendData[2],
                        title: "Last week")
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
    @ObservedObject var data: TrendData
    let title: String

    private var arrowDirection: String {
        data.currentCount < data.previousCount ? "down" : "up"
    }

    private var arrowColor: Color {
        data.currentCount < data.previousCount ? .green : .red
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            VStack(alignment: .center, spacing: 1) {
                Text(String(data.currentCount))
                    .font(.system(size: 28, weight: .semibold))
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            if data.currentCount != 0 || data.previousCount != 0 {
                Image(systemName: "arrow.\(arrowDirection)")
                    .foregroundColor(arrowColor)
            }
        }
        .padding()
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


struct RealTimeCounterView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeCounter(data: TrendDataContainer.preview)
    }
}
