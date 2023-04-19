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
        
        let storeURL: URL = container.persistentStoreDescriptions.first?.url ?? URL(fileURLWithPath: "")

        // Delete the existing persistent store file
        do {
            try FileManager.default.removeItem(at: storeURL)
        } catch let error {
            print("Failed to delete persistent store: \(error)")
        }
        
        for store in container.persistentStoreCoordinator.persistentStores {
            try? container.persistentStoreCoordinator.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
        }
        
        print("The persistent store has been reset!")
    }
    
}
