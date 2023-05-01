//
//  ChartDataContainer.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 01/05/2023.
//

import Foundation

class ChartDataContainer: ObservableObject, Identifiable {
    @Published var occurences: [Occurence]

    init(occurences: [Occurence] = []) {
        self.occurences = occurences
    }

    // TODO: fill up with mock data for preview
    static var preview: ChartDataContainer {
        return ChartDataContainer()
    }
}
