//
//  HomeView.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 18/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("tracking") var isTrackedBehaviorViewActive: Bool = false
    @State private var showWelcomePopup = true
    @State private var showRealTimeCounter = false
    let selectedBehavior: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                Spacer()
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
                if showRealTimeCounter {
                    HStack {
                        Spacer()
                        RealTimeCounter()
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        RealTimeCounterPlaceholder()
                        Spacer()
                    }
                }
                Spacer()
                LineChartDetails()
                Spacer()
                Divider()
            }
            
            .onAppear {
                if !isTrackedBehaviorViewActive {
                    showWelcomePopup = true
                    showRealTimeCounter = false
                } else {
                    showWelcomePopup = false
                    showRealTimeCounter = true
                }
            }
            
            if showWelcomePopup {
                WelcomePopUp(title: "Welcome!",
                             message: "You don’t have any data yet.\n\nWhenever you notice yourself biting your nails, track it in the watch app by pressing the button.\nThen you’ll be able to see your data here.",
                             onCancel: {
                    showWelcomePopup = false
                    // if there are data we should set the
                    // showRealTimeCounter = true
                             })
            }
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
