//
//  TrackerViewModel.swift
//  BeMindful
//
//  Created by Martin Karlik on 12/03/2023.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class OccurenceViewModel: ObservableObject {

    @Published var occurences: [Occurence] = []

    private let dataController: DataController
    private let request = NSFetchRequest<Occurence>(entityName: "Occurence")
    
    init() {
        dataController = DataController(containerName: "Occurences")
        occurences = dataController.fetchData(request: request)
    }
    
    func addOccurence(occurenceTimestamp: Date) {
        _ = Occurence(context: dataController.context, timestamp: occurenceTimestamp, type: "Nail biting")
        dataController.saveData()
        // Until I find a prettier solution to auto-update after save
        occurences = dataController.fetchData(request: request)
    }
}
