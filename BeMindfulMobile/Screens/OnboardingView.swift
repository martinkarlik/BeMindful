//
//  OnboardingView.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 18/04/2023.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var showTrackedBehaviorView = false
    @ObservedObject var viewModel: OccurenceViewModel
    var logoImage: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to BeMindful!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkPurple"))
                    .padding(.top, 50)
                
                Image(logoImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)
                
                Text("This is an app that helps you achieve your goals by tracking your daily behavior.\n\n You can choose from a list of predefined behaviors or create your own custom behavior.\n\n You can track your progress over time and receive reminders to stay on track.")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color("DarkPurple"))
                    .padding(50)
                
                Spacer()
                
                NavigationLink(
                    destination: TrackedBehaviorView(viewModel: viewModel),
                    isActive: $showTrackedBehaviorView,
                    label: {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: 300)
                            .background(.white)
                            .cornerRadius(8)
                            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                    })
                    .padding(.bottom, 50)
                    .simultaneousGesture(TapGesture().onEnded {
                        isOnboardingViewActive = false
                        showTrackedBehaviorView = true
                    })
                    .buttonStyle(PlainButtonStyle())
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            }
            .navigationBarHidden(true)
            //.background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OccurenceViewModel.preview, logoImage: "LaunchIcon")
    }
}
