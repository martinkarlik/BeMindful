//
//  ChoiceSelection.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 12/04/2023.
//

import SwiftUI



struct TrackedBehaviorView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @AppStorage("tracking") var isTrackedBehaviorViewActive: Bool = true
    @State private var showAlert = false
    @State private var showConfirmationPopup = false
    @State private var showDashboardView = false
    @State var selectedBehavior: TrackedBehavior?
    @State var customBehavior: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
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
                                    if behavior == .behavior5 {
                                        TextField("Enter custom behavior", text: $customBehavior, onCommit: {
                                            if !customBehavior.isEmpty {
                                                selectedBehavior = .behavior5
                                            }
                                        })
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding(.horizontal, 16)
                                        .frame(maxWidth: 350, minHeight: 41)
                                        .background(Color("Purple").opacity(0.8))
                                        .cornerRadius(8)
                                        .shadow(color: Color.gray.opacity(1), radius: 4, x: 0, y: 2)
                                    } else {
                                        Label(behavior.rawValue, systemImage: "checkmark")
                                            .foregroundColor(.white)
                                            .fontWeight(.regular)
                                            .frame(maxWidth: 350, minHeight: 41)
                                            .background(Color("Purple").opacity(0.8))
                                            .cornerRadius(8)
                                            .shadow(color: Color.gray.opacity(1), radius: 4, x: 0, y: 2)
                                            .labelStyle(TrailingImageLabelStyle())
                                    }
                                }
                                else {
                                    Text(behavior.rawValue)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.regular)
                                        .frame(maxWidth: 350, minHeight: 41)
                                        .foregroundColor(.white)
                                        .background(Color("Purple").opacity(0.8))
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
                            if selectedBehavior != nil || !customBehavior.isEmpty {
                                isTrackedBehaviorViewActive = false
                                showConfirmationPopup = true
                            } else {
                                showAlert = true
                            }
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
                    .padding(.bottom, 16)
                    .padding(.trailing, 16)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Please select a behavior"), message: Text("You must select a behavior or enter a custom behavior to continue."), dismissButton: .default(Text("OK")))
                    }
                    
                }
                
                if showConfirmationPopup {
                    if let selectedBehavior {
                        ConfirmationPopup(
                            title: "Great!",
                            message: "From now on you can track your \(selectedBehavior.rawValue) behaviour.\n\nYou are already one step closer to breaking the habit!",
                            onConfirm: {
                                print("Confirmed")
                                showConfirmationPopup = false
                                navigateToDashboardTabBar(selectedBehavior: "\(selectedBehavior.rawValue)")
                            },
                            onCancel: {
                                print("Canceled")
                                showConfirmationPopup = false
                            }
                        )
                    } else {
                        ConfirmationPopup(
                            title: "Great!",
                            message: "From now on you can track your selected behaviour.\n\nYou are already one step closer to breaking the habit!",
                            onConfirm: {
                                print("Confirmed")
                                showConfirmationPopup = false
                                navigateToDashboardTabBar(selectedBehavior: "Other")
                            },
                            onCancel: {
                                print("Canceled")
                                showConfirmationPopup = false
                            }
                        )
                    }
                }

            }
            
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .navigationBarHidden(true)
    }
}

private func navigateToDashboardTabBar(selectedBehavior: String) {
    let dashboardTabBar = DashboardTabBar(selectedBehavior: selectedBehavior)
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: dashboardTabBar)
        window.makeKeyAndVisible()
    }
}

struct TrailingImageLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
                .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct ChoiceSelection_Previews: PreviewProvider {
    static var previews: some View {
        TrackedBehaviorView()
    }
}
