//
//  Occurence+CoreDataProperties.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 26/04/2023.
//
//

import Foundation
import CoreData

// CoreData generated file, I'll find out if it's strictly necessary, but stays like this for now
extension Occurence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Occurence> {
        return NSFetchRequest<Occurence>(entityName: "Occurence")
    }
}

extension Occurence : Identifiable {

}
