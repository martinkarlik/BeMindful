//
//  TrackerViewModel.swift
//  BeMindful
//
//  Created by Martin Karlik on 12/03/2023.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class OccurenceViewModel: ObservableObject {

    @Published var occurences: [Occurence] = []
    @Published var trendData = TrendDataContainer.preview
    //@Published var trendData = TrendDataContainer.emptyPreview
    @Published var lineChartData = LineChartData.preview
   // @Published var lineChartData = LineChartData.emptyPreview

    private let dataController: DataController
    private let request = NSFetchRequest<Occurence>(entityName: "Occurence")

    private let secondsInHour: Double = 3600
    private let secondsInDay: Double = 86400
    private let secondsInWeek: Double = 604800

    static var preview: OccurenceViewModel {
        let viewModel = OccurenceViewModel(inMemory: true)
        // TODO: populate with mock data for previews
        viewModel.occurences = [
            Occurence(context: viewModel.dataController.context, timestamp: Date(), type: "Nail biting")
        ]
        viewModel.trendData = viewModel.getTrendData(from: viewModel.occurences)

        return viewModel
    }
    
    init(inMemory: Bool = false) {
        dataController = DataController(containerName: "Occurences", inMemory: inMemory)
        if !inMemory {
            occurences = dataController.fetchData(request: request)
            // trendData = getTrendData(from: occurences)
//            lineChartData = getLineChartData(from: occurences)
        }
    }
    
    func addOccurence(occurenceTimestamp: Date) {
        _ = Occurence(context: dataController.context, timestamp: occurenceTimestamp, type: "Nail biting")
        dataController.saveData()
        // Until I find a prettier solution to auto-update after save
        occurences = dataController.fetchData(request: request)
    }

    private func getTrendData(from occurences: [Occurence]) -> TrendDataContainer {
        let lastHour = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInHour }
            .count
        let lastDay = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInDay }
            .count
        let lastWeek = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInWeek }
            .count

        let hourBefore = occurences
            .filter { occurence in
                let from = Date() - secondsInHour * 2
                let until = Date() - secondsInHour
                let range = from...until
                return range.contains(occurence.timestamp)
            }
            .count
        let dayBefore = occurences
            .filter { occurence in
                let from = Date() - secondsInDay * 2
                let until = Date() - secondsInDay
                let range = from...until
                return range.contains(occurence.timestamp)
            }
            .count
        let weekBefore = occurences
            .filter { occurence in
                let from = Date() - secondsInWeek * 2
                let until = Date() - secondsInWeek
                let range = from...until
                return range.contains(occurence.timestamp)
            }
            .count

        return TrendDataContainer(trendData: [TrendData(current: lastHour, previous: hourBefore),
                                              TrendData(current: lastDay, previous: dayBefore),
                                              TrendData(current: lastWeek, previous: weekBefore)]
        )
    }

//    private func getLineChartData(from occurences: [Occurence]) -> LineChartData {
//        let lastHour = occurences.filter { -$0.timestamp.timeIntervalSinceNow < secondsInHour }
//        let lastDay = occurences.filter { -$0.timestamp.timeIntervalSinceNow < secondsInDay }
//        let lastWeek = occurences.filter { -$0.timestamp.timeIntervalSinceNow < secondsInWeek }
//        // TODO: find a way to filter for month, as seconds would be over the Integer threshold I think
//        let lastMonth = occurences.filter { -$0.timestamp.timeIntervalSinceNow < secondsInWeek }
//
//        return LineChartData(hour: lastHour, day: lastDay, week: lastWeek, month: lastMonth)
//    }
}
