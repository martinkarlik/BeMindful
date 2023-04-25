//
//  File.swift
//  BeMindful
//
//  Created by Martin Karlik on 19/04/2023.
//

import Foundation
import SwiftUI

struct CheckMarkView: View {
    
    @State private var showCheckmark = false
    
    private var buttonAction: () -> Void
    
    init(buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button(action: {
            self.buttonAction()
            
            withAnimation {
                self.showCheckmark = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTime) {
                withAnimation {
                    self.showCheckmark = false
                }
            }
            
        }) {
            if !showCheckmark {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .frame(width: Constants.buttonDiamater, height: Constants.buttonDiamater)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            } else {
                Image(systemName: "checkmark.seal.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: Constants.buttonDiamater, height: Constants.buttonDiamater)
                    .background(Color.green)
                    .clipShape(Circle())
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
    }
}

extension CheckMarkView {
    
    enum Constants {
        static let buttonDiamater = 80.0
        static let animationTime = 1.0
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
