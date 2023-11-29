//
//  HeartRateFunctionality.swift
//  BeMindfulWatch
//
//  Created by Marina Epitropakis on 22/11/2023.
//

import HealthKit

enum HealthKitError: Error {
    case invalidType
    case notAuthorized
    case noData
    case unknown
    
    
    var errorDescription: String? {
            switch self {
            case .invalidType:
                return "Invalid HealthKit type."
            case .notAuthorized:
                return "HealthKit authorization denied."
            case .noData:
                return "No data to return"
            case .unknown:
                return "Unknown"
            }
        }
}

class HealthKitManager {
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion(.failure(HealthKitError.invalidType))
            return
        }

        let typesToRead = Set([heartRateType])

        healthStore.requestAuthorization(toShare: typesToRead, read: typesToRead) { (success, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(success))
            }
        }
    }

    
    func isAuthorized() -> Bool {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            // Handle the case where the heart rate type is not available
            return false
        }

        let healthStatus = healthStore.authorizationStatus(for: heartRateType)
        return healthStatus == .sharingAuthorized
    }

    // Function to record live heart rate
    func recordLiveHeartRate(completion: @escaping (Result<Double, HealthKitError>) -> Void) {

        // Define the type for heart rate
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion(.failure(.invalidType))
            return
        }

        // Create a query to get the most recent heart rate sample
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast, 
                                                              end: Date(),
                                                              options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        let query = HKSampleQuery(sampleType: heartRateType,
                                  predicate: mostRecentPredicate,
                                  limit: 1,
                                  sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            if let error = error {
                completion(.failure(.invalidType))
                return
            }

            // Extract the heart rate value from the sample, if available
            if let sample = samples?.first as? HKQuantitySample {
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
                completion(.success(heartRate))
            } else {
                // No heart rate data found
                completion(.failure(.noData))
            }
        }

        // Execute the query
        healthStore.execute(query)
    }

}

