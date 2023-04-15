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

class SharedViewModel: ObservableObject {
        
    var moc: NSManagedObjectContext?
    
    init() {}
    
    func addBfrbOccurence(occurenceTimestamp: String) {
        
        guard let moc = moc else {
            return
        }
        
        let newOccurence = Occurence(context: moc)
        newOccurence.id = UUID()
        newOccurence.timestamp = occurenceTimestamp
        
        try? moc.save()
    }
}
