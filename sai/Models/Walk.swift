//
//  Walk.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation
import CoreData

struct Walk: Identifiable {
    var id: UUID = UUID()
    var startedAt: Date
    var finishedAt: Date
    var walkHistory: WalkHistory
    
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
    
    func toCoreData(context: NSManagedObjectContext) -> WalkCoreData {
        let walkCoreData = WalkCoreData(context: context)
        walkCoreData.id = id
        walkCoreData.startedAt = startedAt
        walkCoreData.finishedAt = finishedAt
        walkCoreData.walkHistory = walkHistory.toJSON()
        return walkCoreData
    }
    
    static func fromCoreData(coreData: WalkCoreData) -> Walk {
        let walkHistory = WalkHistory.fromJSON(coreData.walkHistory!)
        return Walk(id: coreData.id!, startedAt: coreData.startedAt!, finishedAt: coreData.finishedAt!, walkHistory: walkHistory)
    }
}
