//
//  History.swift
//  BeMindfulMobile
//
//  Created by Vivien Varadi on 09/05/2023.
//

import Foundation

extension HistoryDataContainer {
    static var changeSignal = true

    static var mock: HistoryDataContainer {
        return HistoryDataContainer(historyData: [ HistoryData(date: Date(), count: 3, timeInterval: "9:00 - 10:00"),
                                                   HistoryData(date: Date(), count: 2, timeInterval: "10:00 - 11:00"),
                                                   HistoryData(date: Date(), count: 4, timeInterval: "11:00 - 12:00"),
                                                   HistoryData(date: Date(), count: 1, timeInterval: "12:00 - 13:00"),
                                                   HistoryData(date: Date(), count: 1, timeInterval: "13:00 - 14:00"),
                                                   HistoryData(date: Date(), count: 1, timeInterval: "14:00 - 15:00"),
                                                   HistoryData(date: Date(), count: 1, timeInterval: "15:00 - 16:00")]
        )
    }
}
