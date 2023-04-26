//
//  PopUpView.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 25/04/2023.
//

import SwiftUI

struct ConfirmationPopup: View {
    let title: String
    let message: String
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
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
                    onCancel()
                }) {
                    Text("Back")
                        .foregroundColor(Color.white)
                        .fontWeight(.regular)
                        .frame(maxWidth: 120, minHeight: 41)
                        .foregroundColor(.white)
                        .background(Color("Purple").opacity(0.8))
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                Button(action: {
                    onConfirm()
                }) {
                    Text("Continue")
                        .fontWeight(.regular)
                        .frame(maxWidth: 120, minHeight: 41)
                        .foregroundColor(.black)
                        .background(Color.white)
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


struct ConfirmationPopup_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationPopup(title: "HI", message: "Heyyefeuyfeuyfge", onConfirm: {}, onCancel:{} )
    }
}
