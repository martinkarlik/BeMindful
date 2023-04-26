//
//  LaunchView.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 06/04/2023.
//

import SwiftUI

struct LaunchView: View {
    
    var launchImage: String
    
    var body: some View {
        Image(launchImage)
            .resizable()
            .scaledToFit()
            .foregroundColor(.purple)
            .clipped()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(launchImage: "LaunchIcon")
    }
}
