//
//  DashboardTabBar.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 26/04/2023.
//

import SwiftUI

struct DashboardTabBar: View {
    @ObservedObject var viewModel: OccurenceViewModel
    let selectedBehavior: String
    
    enum Tab {
        case dashboard
        case history
    }
    
    @State private var selectedTab = Tab.dashboard
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(viewModel: viewModel, selectedBehavior: selectedBehavior)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Dashboard")
                }
                .tag(Tab.dashboard)
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
                .tag(Tab.history)
        }
    }
}


struct DashboardTabBar_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabBar(viewModel: OccurenceViewModel.preview, selectedBehavior: "Test")
    }
}
