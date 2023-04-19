//
//  ContainerView.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 18/04/2023.
//

import SwiftUI

struct ContainerView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @AppStorage("tracking") var isTrackedBehaviorViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            }
            else {
                TrackedBehaviorView()
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
