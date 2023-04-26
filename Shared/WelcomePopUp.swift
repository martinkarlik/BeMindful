//
//  WelcomePopUp.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 26/04/2023.
//

import SwiftUI

struct WelcomePopUp: View {
    let title: String
    let message: String
    let onStart: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("DarkPurple"))
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("DarkPurple"))
                .padding()
            HStack {
                Button(action: {
                    onStart()
                }) {
                    Text("Start")
                        .fontWeight(.regular)
                        .frame(maxWidth: 120, minHeight: 41)
                        .foregroundColor(.black)
                        .background(Color("PopUp"))
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color("PopUp"))
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct WelcomePopUp_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePopUp(title: "HI", message: "isuhviruhverih", onStart: {})
    }
}
