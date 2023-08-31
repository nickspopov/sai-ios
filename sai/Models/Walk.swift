//
//  Walk.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation
import CoreData
import FirebaseFirestoreSwift

struct Walk: Codable, Identifiable {
    var id: String = UUID().uuidString
    var startedAt: Date
    var finishedAt: Date
    var walkHistory: WalkHistoryModel
    var user: String = "default"
    
    // MARK: - Computed properties
    
    var duration: TimeInterval {
        return finishedAt.timeIntervalSince(startedAt)
    }
    
    var distance: Double {
        return getDistance()
    }
    
    lazy var lazyDistance: Double = {getDistance()}()
    
    private func getDistance() -> Double {
        var distance = 0.0
        if walkHistory.history.count < 2 {
            return distance
        }
        for i in 0..<walkHistory.history.count - 1 {
            distance += walkHistory.history[i].distance(to: walkHistory.history[i + 1])
        }
        return distance
    }
    
    
    // MARK: - Core Data
    func toCoreData(context: NSManagedObjectContext) -> WalkCoreData {
        let walkCoreData = WalkCoreData(context: context)
        walkCoreData.id = id
        walkCoreData.startedAt = startedAt
        walkCoreData.finishedAt = finishedAt
        walkCoreData.walkHistory = walkHistory.toJSON()
        return walkCoreData
    }
    
    static func fromCoreData(coreData: WalkCoreData) -> Walk {
        let walkHistory = WalkHistoryModel.fromJSON(coreData.walkHistory)
        return Walk(id: coreData.id, startedAt: coreData.startedAt, finishedAt: coreData.finishedAt, walkHistory: walkHistory)
    }
}

// MARK: - WalkHistory
struct WalkHistoryModel: Codable {
    var history: [Location]
    
    mutating func addLocation(_ location: Location) {
        history.append(location)
    }
    
    func toJSON() -> String {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(history)
        let result = String(data: data, encoding: .utf8)!
        return result
    }
    
    static func fromJSON(_ json: String) -> WalkHistoryModel {
        let decoder = JSONDecoder()
        let data = json.data(using: .utf8)!
        let history = try! decoder.decode([Location].self, from: data)
        return WalkHistoryModel(history: history)
    }
}
