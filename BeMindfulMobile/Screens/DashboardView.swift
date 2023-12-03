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
    @State private var timeRange: TimeRange = .hour
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
                    Text("Last Synced: \(Utils.formatDate(date: viewModel.lastSynced, to: "HH:mm") ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    List {
                        HStack {
                            RealTimeCounter(data: viewModel.trendData)
                        }

                        TimeRangePicker(value: $timeRange)
                            .padding(.bottom)
                        BarChartDetails(data: viewModel.lineChartData,
                                        timeRange: $timeRange,
                                        selectedBehavior: selectedBehavior)
                            .listRowSeparator(.hidden)
                        HeartGraphDetails(data: viewModel.heartChartData,
                                          timeRange: $timeRange)
                            .listRowSeparator(.hidden)
                        Divider()
                        CalendarHeatMap(data: HeatMapDataContainer.mock)
                            .frame(maxWidth: .infinity)
                            .listRowSeparator(.visible)
                        // This will appear all the time
                        UserInputView(question: "Self Reflect: \n\nWhat were you doing the last time you added an occurrence?", placeholder: "Enter your reflection..", buttonText: "Save Reflection")
                            .frame(maxWidth: .infinity)
                        // This will only appear once in a while
                        UserInputView(question: "Help Others: \n\nWhat helps you stop when you do the behavior?", placeholder: "Enter your advice..", buttonText: "Save")
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
