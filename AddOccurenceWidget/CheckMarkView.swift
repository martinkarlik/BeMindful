//
//  CheckMarkView.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 04/12/2023.
//

import Foundation
import AppIntents
import SwiftUI

struct CheckMarkView: View {

    @State private var showCheckmark = false

    private var intent: AddOccurenceIntent

    init(intent: AddOccurenceIntent) {
        self.intent = intent
    }

    var body: some View {
        Button(intent: intent) {
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
        .onTapGesture {
            withAnimation {
                self.showCheckmark = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationTime) {
                withAnimation {
                    self.showCheckmark = false
                }
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
