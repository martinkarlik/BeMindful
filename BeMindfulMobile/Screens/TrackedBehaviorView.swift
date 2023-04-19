//
//  ChoiceSelection.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 12/04/2023.
//

import SwiftUI

enum TrackedBehavior: String, CaseIterable {
    case behavior1 = "Behavior 1"
    case behavior2 = "Behavior 2"
    case behavior3 = "Behavior 3"
    case behavior4 = "Behavior 4"
    case behavior5 = "Behavior 5"
}

struct TrackedBehaviorView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @AppStorage("tracking") var isTrackedBehaviorViewActive: Bool = true
    @State var selectedBehavior: TrackedBehavior?
    
    var body: some View {
        VStack {
            Text("Tracked Behavior")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            Text("Choose the one you want to track")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            ForEach(TrackedBehavior.allCases, id: \.self) { behavior in
                Button(action: {
                    if behavior == selectedBehavior {
                        // Deselect the button if it's already selected
                        selectedBehavior = nil
                    } else {
                        // Select the button and deselect all the other buttons
                        selectedBehavior = behavior
                    }
                }) {
                    HStack {
                        if selectedBehavior == behavior {
                            Label(behavior.rawValue, systemImage: "checkmark")
                                .foregroundColor(Color.white)
                                .fontWeight(.regular)
                                .frame(maxWidth: 350, minHeight: 41)
                                .foregroundColor(.white)
                                .background(Color(hex: 0x5E63B6).opacity(0.8))
                                .cornerRadius(8)
                                .shadow(color: Color.gray.opacity(1),
                                        radius: 4, x: 0, y: 2)
                        }
                        else {
                            Text(behavior.rawValue)
                                .foregroundColor(Color.white)
                                .fontWeight(.regular)
                                .frame(maxWidth: 350, minHeight: 41)
                                .foregroundColor(.white)
                                .background(Color(hex: 0x5E63B6).opacity(0.8))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.bottom, 16)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    isTrackedBehaviorViewActive = false
                }) {
                    Text("Continue")
                        .fontWeight(.regular)
                        .frame(maxWidth: 120, minHeight: 41)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.1),
                                radius: 4, x: 0, y: 2)
                    
                        
                }
                .padding(.trailing, 16)
                .shadow(radius: 2, y: 2)
            }
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 16)
            .padding(.trailing, 16)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}






extension Color {
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: 1
        )
    }
}


struct ChoiceSelection_Previews: PreviewProvider {
    static var previews: some View {
        TrackedBehaviorView()
    }
}
