//
//  DataController.swift
//  BeMindful
//
//  Created by Martin Karlik on 15/04/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Occurences")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Call this from the initializer to reset the real data on device: We don't support flexible data deletion yet
    // This WILL delete all user's data so treat lightly
    func resetAllData() {
        for store in container.persistentStoreCoordinator.persistentStores {
            try? container.persistentStoreCoordinator.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
        }
    }
    
}
