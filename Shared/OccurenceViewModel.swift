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

    // We can probably make occurences not published after all the data and history is done
    @Published var occurences: [Occurence] = []
    @Published var trendData = TrendDataContainer()
    @Published var lineChartData = LineChartData()
    @Published var heartRateData = LineChartData() // might need to be changed, added for mock
    @Published var historyData = HistoryDataContainer()
    @Published var heatMapData = HeatMapDataContainer()


    private let dataController: DataController
    private let request = NSFetchRequest<Occurence>(entityName: "Occurence")
    private let calendar = Calendar.current

    private let secondsInHour: Double = 3600
    private let secondsInDay: Double = 86400
    private let secondsInWeek: Double = 604800
    
    init(inMemory: Bool = false) {
        dataController = DataController(containerName: "Occurences", inMemory: inMemory)
        if !inMemory {
            occurences = dataController.fetchData(request: request)
            trendData = getTrendData(from: occurences)
            lineChartData = getLineChartData(from: occurences)
            heatMapData = getHeatmapData()
        }
    }

    // Used for generating a mock viewModel 
    private init(trendData: TrendDataContainer,
                 lineChartData: LineChartData,
                 heartRateData: LineChartData,
                 historyData: HistoryDataContainer) {
        self.dataController = DataController(containerName: "Occurences", inMemory: true)
        self.occurences = []
        self.trendData = trendData
        self.lineChartData = lineChartData
        self.heartRateData = heartRateData
        self.historyData = historyData
    }
    
    func addOccurence(occurenceTimestamp: Date) {
        _ = Occurence(context: dataController.context, timestamp: occurenceTimestamp, type: "Hair pulling")
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

    private func getLineChartData(from occurences: [Occurence]) -> LineChartData {
        let lastHour = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInHour }
            .sorted()
        let lastDay = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInDay }
            .sorted()
        let lastWeek = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInWeek }
            .sorted()
        let lastMonth = occurences
            .filter { -$0.timestamp.timeIntervalSinceNow < secondsInWeek }
            .sorted()

        let lastHourDict = groupDataByCustomTimeInterval(data: lastHour, timeInterval: .minute)
        let lastDayDict = groupDataByCustomTimeInterval(data: lastDay, timeInterval: .hour)
        let lastWeekDict = groupDataByCustomTimeInterval(data: lastWeek, timeInterval: .weekdayOrdinal)
        let lastMonthDict = groupDataByCustomTimeInterval(data: lastMonth, timeInterval: .day)

        return LineChartData(hour: lastHourDict, day: lastDayDict, week: lastWeekDict, month: lastMonthDict)
    }

    private func getHeatmapData() -> HeatMapDataContainer {
        var dateComponents = DateComponents()
        dateComponents.year = calendar.component(.year, from: Date())
        dateComponents.month = calendar.component(.month, from: Date())
        guard let currentDate = calendar.date(from: dateComponents) else { return HeatMapDataContainer() }

        var cellData: [HeatmapCellData] = []
        for (date, count) in lineChartData.monthly where calendar.isDate(date, equalTo: currentDate, toGranularity: .month){
            let data = HeatmapCellData(date: date, count: count)
            cellData.append(data)
        }

        return HeatMapDataContainer(heatmapData: cellData.sorted{ $0.date < $1.date })
    }

    private func groupDataByCustomTimeInterval(data: [Occurence], timeInterval: Calendar.Component) -> [Date: Int] {
        guard let first = data.first else { return [:] }
        var result: [Date: Int] = [:]
        var currentDate = first.timestamp
        var currentSum: Int = 0

        for occurence in data {
            let currentComponent = calendar.component(timeInterval, from: currentDate)
            let occurenceComponent = calendar.component(timeInterval, from: occurence.timestamp)
            if occurenceComponent == currentComponent {
                currentSum += 1
            } else {
                result[currentDate] = currentSum
                currentDate = occurence.timestamp
                currentSum = 0
            }
        }

        // Add the last interval
        result[currentDate] = currentSum

        return result
    }
}

extension OccurenceViewModel {
    static var mock: OccurenceViewModel {
        let viewModel = OccurenceViewModel(trendData: TrendDataContainer.mock,
                                           lineChartData: LineChartData.mock,
                                           heartRateData: LineChartData.mockHeart,
                                           historyData: HistoryDataContainer.mock)
        return viewModel
    }
}
