//
//  Utils.swift
//  BeMindfulMobile
//
//  Created by Marina Epitropakis on 22/03/2023.
//
import Foundation
import Charts

struct Utils {
    static func round(value: Double, decimalPlaces: Int = 0) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return Darwin.round(value * multiplier) / multiplier
    }

    static func formatDate(date: Date, to format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    private static func getHourEdges(from date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        var startComponent = DateComponents()
        startComponent.minute = 0
        var endComponent = DateComponents()
        endComponent.minute = 59
        guard let start = calendar.nextDate(after: date, matching: startComponent, matchingPolicy: .nextTime, direction: .backward),
              let end = calendar.nextDate(after: date, matching: endComponent, matchingPolicy: .nextTime) 
        else { return (Date(), Date()) }

        return (start, end)
    }

    private static func getDayEdges(from date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        var startComponent = DateComponents()
        startComponent.hour = 0
        var endComponent = DateComponents()
        endComponent.hour = 23
        guard let start = calendar.nextDate(after: date, matching: startComponent, matchingPolicy: .nextTime, direction: .backward),
              let end = calendar.nextDate(after: date, matching: endComponent, matchingPolicy: .nextTime) 
        else { return (Date(), Date()) }

        return (start, end)
    }

    private static func getWeekEdges(from date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        var startComponent = DateComponents()
        startComponent.weekday = 1
        var endComponent = DateComponents()
        endComponent.weekday = 7
        endComponent.hour = 23
        guard let start = calendar.nextDate(after: date, matching: startComponent, matchingPolicy: .nextTime, direction: .backward),
              let end = calendar.nextDate(after: date, matching: endComponent, matchingPolicy: .nextTime)
        else { return (Date(), Date()) }

        return (start, end)
    }

    private static func getMonthEdges(from date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        guard let interval = calendar.dateInterval(of: .month, for: date) else { return (Date(), Date()) }
        var startComponent = DateComponents()
        startComponent.day = 1
        var endComponent = DateComponents()
        endComponent.day = calendar.component(.day, from: interval.end)
        guard let start = calendar.nextDate(after: date, matching: startComponent, matchingPolicy: .nextTime, direction: .backward),
              let end = calendar.nextDate(after: date, matching: endComponent, matchingPolicy: .nextTime)
        else { return (Date(), Date()) }

        return (start, end)
    }

    static func getXDomain(for timeRange: TimeRange) -> [Date] {
        let date = Date()
        switch timeRange {
        case .hour:
            let hourBounds = getHourEdges(from: date)
            return [hourBounds.start, hourBounds.end]
        case .day:
            let dayBounds = getDayEdges(from: date)
            return [dayBounds.start, dayBounds.end]
        case .week:
            let weekBounds = getWeekEdges(from: date)
            return [weekBounds.start, weekBounds.end]
        case .month:
            let monthBounds = getMonthEdges(from: date)
            return [monthBounds.start, monthBounds.end]
        }
    }

    static func getXComponent(for timeRange: TimeRange) -> Calendar.Component {
        switch timeRange {
        case .hour:
            return .minute
        case .day:
            return .hour
        case .week:
            return .weekday
        case .month:
            return .day
        }
    }

    static func getXFormat(for timeRange: TimeRange) -> Date.FormatStyle {
        switch timeRange {
        case .hour:
            return .dateTime.hour().minute()
        case .day:
            return .dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()
        case .week:
            return .dateTime.weekday(.abbreviated)
        case .month:
            return .dateTime.month().day()
        }
    }

    static func getXValues(for timeRange: TimeRange) -> AxisMarkValues {
        switch timeRange {
        case .hour:
            return .automatic
        case .day:
            return .automatic
        case .week:
            return .automatic(desiredCount: 7)
        case .month:
            return .automatic
        }
    }
}

enum TrackedBehavior: String, CaseIterable {
    case behavior1 = "Nail Picking"
    case behavior2 = "Nail Biting"
    case behavior3 = "Cheek Biting"
    case behavior4 = "Hair Pulling"
    case behavior5 = "Other..."
}

extension Dictionary where Key == Date, Value == Int {
    func findValue(at date: Date, toGranularity component: Calendar.Component) -> Int? {
        let calendar = Calendar.current
        for (key, value) in self {
            if calendar.isDate(key, equalTo: date, toGranularity: component) {
                return value
            }
        }
        return nil
    }
}
