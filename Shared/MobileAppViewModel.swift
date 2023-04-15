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

class MobileAppViewModel: ObservableObject {
        
    var moc: NSManagedObjectContext?
    
    init() {}
    
    func addBfrbOccurence(occurenceTimestamp: Date) {
        
        guard let moc = moc else {
            return
        }
        
        let newOccurence = Occurence(context: moc)
        newOccurence.id = UUID()
        newOccurence.timestamp = occurenceTimestamp
        
        try? moc.save()
    }
}
