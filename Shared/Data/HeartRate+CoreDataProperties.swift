//
//  HeartRate+CoreDataProperties.swift
//  BeMindful
//
//  Created by Marina Epitropakis on 29/11/2023.
//
//

import Foundation
import CoreData


extension HeartRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeartRate> {
        return NSFetchRequest<HeartRate>(entityName: "HeartRate")
    }
}

extension HeartRate: Comparable {
    public static func < (lhs: HeartRate, rhs: HeartRate) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
}

extension HeartRate : Identifiable {

}
