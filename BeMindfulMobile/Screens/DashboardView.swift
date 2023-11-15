//
//  HomeView.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 18/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("tracking") var isTrackedBehaviorViewActive: Bool = true
    @ObservedObject var viewModel: OccurenceViewModel
    @State private var showWelcomePopup = false
    // @State private var timeRange: TimeRange = .lastHour
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
                    Text("Last Synced: viewModel.lineChartData.daily.dropLast())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    Spacer()
                    HStack {
                        Spacer()
                        RealTimeCounter(data: viewModel.trendData)
                        Spacer()
                    }
                    Spacer()
                    List {
                        LineChartDetails(data: viewModel.lineChartData, selectedBehavior: selectedBehavior)
                            .listRowSeparator(.hidden)
                        HeartGraphDetails(data: LineChartData.mockHeart)
                            .listRowSeparator(.hidden)
                        CalendarHeatMap(data: HeatMapDataContainer.mock)
                            .frame(maxWidth: .infinity)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    Divider()
                }                
                .onAppear {
                    if !isTrackedBehaviorViewActive {
                        showWelcomePopup = false
                    } else {
                        showWelcomePopup = true
                    }
                }
                
                if showWelcomePopup {
                    WelcomePopUp(title: "Welcome!",
                                 message: "You don’t have any data yet.\n\nWhenever you notice yourself biting your nails, track it in the watch app by pressing the button.\nThen you’ll be able to see your data here.",
                                 onCancel: {
                        showWelcomePopup = false
                        isTrackedBehaviorViewActive = false
                        
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
        DashboardView(viewModel: OccurenceViewModel.mock, selectedBehavior: TrackedBehavior.behavior1.rawValue)
    }
}
