//
//  DataController.swift
//  BeMindful
//
//  Created by Martin Karlik on 15/04/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container: NSPersistentContainer
    var context : NSManagedObjectContext { container.viewContext }
    
    init(containerName: String, inMemory: Bool = false) {
        container = NSPersistentContainer(name: containerName)
        if inMemory, let first = container.persistentStoreDescriptions.first {
            first.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func fetchData<Result>(request: NSFetchRequest<Result>) -> [Result] {
        var result: [Result] = []
        do {
            result = try context.fetch(request)
        } catch let error {
            print("ERROR: \(error)")
        }
        return result
    }

    func saveData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
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
