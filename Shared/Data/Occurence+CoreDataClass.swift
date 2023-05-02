//
//  Occurence+CoreDataClass.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 26/04/2023.
//
//

import Foundation
import CoreData

@objc(Occurence)
public class Occurence: NSManagedObject {

    @NSManaged public private(set) var id: UUID
    @NSManaged public private(set) var timestamp: Date
    @NSManaged public var type: String

    public init(context: NSManagedObjectContext,
                id: UUID = UUID(),
                timestamp: Date,
                type: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Occurence", in: context)!
        super.init(entity: entity, insertInto: context)
        self.id = id
        self.timestamp = timestamp
        self.type = type
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
