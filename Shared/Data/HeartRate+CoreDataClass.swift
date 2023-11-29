//
//  HeartRate+CoreDataClass.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 29/11/2023.
//
//

import Foundation
import CoreData

@objc(HeartRate)
public class HeartRate: NSManagedObject {
    
    @NSManaged public private(set) var id: UUID
    @NSManaged public private(set) var timestamp: Date
    @NSManaged public private(set) var bpm: Int32

    public init(context: NSManagedObjectContext,
                id: UUID = UUID(),
                timestamp: Date,
                bpm: Int32) {
        guard let entity = NSEntityDescription.entity(forEntityName: "HeartRate", in: context) else {
            fatalError("HeartRate entity not found")
        }
        super.init(entity: entity, insertInto: context)
        self.id = id
        self.timestamp = timestamp
        self.bpm = bpm
    }

    @objc
    override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    @available(*, unavailable)
    public init() {
        fatalError("\(#function) not implemented")
    }

    @available(*, unavailable)
    public convenience init(context: NSManagedObjectContext) {
        fatalError("\(#function) not implemented")
    }
}

