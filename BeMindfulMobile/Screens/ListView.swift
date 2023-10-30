//
//  ListView.swift
//  BeMindfulMobile
//
//  Created by Martin Karlik on 18/05/2023.
//

import Foundation
import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: OccurenceViewModel
    let selectedBehavior: String
    
    var body: some View {
        VStack {
            List(viewModel.occurences.reversed()) { occurence in
                Text(formatDate(occurence.timestamp) ?? "Unknown")
            }
            CheckMarkView() {
                viewModel.addOccurence(occurenceTimestamp: Date())
            }
        }
    }
    
}

extension ListView {
    
    func formatDate(_ date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
