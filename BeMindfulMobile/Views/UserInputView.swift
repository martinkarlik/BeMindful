//
//  UserReflections.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 03/12/2023.
//

import SwiftUI

struct UserInputView: View {
    @State private var reflectionText: String = ""
    var question: String = "Question"
    var placeholder: String = "Enter your answer.."
    var buttonText: String = "Save"
    
    var body: some View {
        VStack {
            Text(question)
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(placeholder, text: $reflectionText)
                .foregroundColor(Color.black)
                .fontWeight(.regular)
                .frame(maxWidth: 250, minHeight: 41)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .foregroundColor(.white)
                .background(.white)
                .cornerRadius(8)
            Button(buttonText) {
                saveResponse()
                resetTextField()
            }
            .fontWeight(.regular)
            .frame(maxWidth: 140, minHeight: 41)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(8)
            .padding()
            .shadow(color: Color.gray.opacity(1), radius: 4, x: 0, y: 2)
        }
        .background(Color("Purple").opacity(0.8))
        .cornerRadius(8)
    }
    
    func saveResponse() {
        // Later I will create a new entity in the Data Model named "Reflections"
    }
    func resetTextField() {
        reflectionText = ""
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView(question: "Why", placeholder: "Enter", buttonText: "Save")
    }
}

