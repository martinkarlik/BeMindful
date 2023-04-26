//
//  HomeView.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 18/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("tracking") var isTrackedBehaviorViewActive: Bool = false
    let selectedBehavior: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Dashboard: \(selectedBehavior)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkPurple"))
                    .padding(.leading)
                Spacer()
            }
            Text("Last Synced: 9:39 AM")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading)
            Spacer()
            HStack {
                Spacer()
                RealTimeCounter()
                Spacer()
            }
            Spacer()
            LineChartDetails()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView( selectedBehavior: TrackedBehavior.behavior1.rawValue)
    }
}
