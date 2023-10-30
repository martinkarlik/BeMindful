//
//  Occurence+Comparable.swift
//  BeMindful
//
//  Created by Vivien Varadi on 30/10/2023.
//

import Foundation

extension Occurence: Comparable {
    public static func < (lhs: Occurence, rhs: Occurence) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }

}
