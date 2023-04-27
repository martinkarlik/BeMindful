//
//  BeMindfulWidgetBundle.swift
//  BeMindfulWidget
//
//  Created by Marina Epitropakis on 26/04/2023.
//

import WidgetKit
import SwiftUI

@main
struct BeMindfulWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        BeMindfulWidget()
        BeMindfulWidgetLiveActivity()
    }
}
