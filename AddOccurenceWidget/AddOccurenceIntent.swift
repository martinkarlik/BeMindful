//
//  AddOccurenceIntent.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 04/12/2023.
//

import Foundation
import AppIntents

struct AddOccurenceIntent: AppIntent {

    static var title: LocalizedStringResource = "Add Occurence"
    static var description: IntentDescription = IntentDescription("Add new BFRB occurence")

    init() { }

    func perform() async throws -> some IntentResult {
        DataController.shared.createOccurence(timestamp: Date())
        return .result()
    }
}
