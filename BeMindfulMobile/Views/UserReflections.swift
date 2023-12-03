//
//  UserReflections.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 03/12/2023.
//

import SwiftUI

struct SelfReflectionView: View {
    @State private var reflectionText: String = ""
    
    var body: some View {
        VStack {
            Text("What were you doing the last time you added an occurrence?")
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Enter your reflection...", text: $reflectionText)
                .foregroundColor(Color.black)
                .fontWeight(.regular)
                .frame(maxWidth: 250, minHeight: 41)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .foregroundColor(.white)
                .background(.white)
                .cornerRadius(8)
            // Add a button or any other UI element to save the reflectionText
            Button("Save Reflection") {
                // Implement your logic to save the reflectionText
                saveReflection()
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
    
    func saveReflection() {
        // Later I will create a new entity in the Data Model named "Reflections"
    }
    func resetTextField() {
        reflectionText = ""
    }
}

struct SelfReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelfReflectionView()
    }
}

