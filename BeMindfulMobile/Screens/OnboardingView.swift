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
    var logoImage: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to BeMindful!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkPurple"))
                    .padding(.top, 50)
                
                Image(logoImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.top, 0)
                ScrollView {
                    Text("This application is designed to help you overcome your body-focused repetitive behaviors (BFRBs) and achieve your goals by tracking your daily behavior.\nYou can choose from a list of predefined behaviors or create your own custom behavior.\n\nYou can track your progress over time through the watch application or the app widget and check your statistics on your mobile, where several visualisations are available to understand your data. \n\nTogether, let's make progress towards a happier, healthier you!")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color("DarkPurple"))
                        .padding(50)
                    
                    // Spacer()
                }
                NavigationLink(
                    destination: TrackedBehaviorView(),
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
        OnboardingView(logoImage: "LaunchIcon")
    }
}
