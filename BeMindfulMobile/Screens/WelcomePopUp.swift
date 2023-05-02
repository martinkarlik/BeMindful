//
//  WelcomePopUp.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 01/05/2023.
//

import SwiftUI

struct WelcomePopUp: View {
    let title: String
    let message: String
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("DarkPurple"))
                .padding()
            Button(action: {
                onCancel()
            }) {
                Text("Start!")
                    .fontWeight(.regular)
                    .frame(maxWidth: 120, minHeight: 41)
                    .foregroundColor(Color("DarkPurple"))
                    .background(Color("PopUp"))
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
            }
        }
        .padding()
        .background(Color("PopUp"))
        .cornerRadius(16)
        .frame(maxWidth: 320, minHeight: 41)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct WelcomePopUp_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePopUp(title: "HI", message: "Heyyefeuyfeuyfge"
                     , onCancel:{} )
    }
}
