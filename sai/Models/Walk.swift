//
//  Walk.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation


struct Walk: Identifiable {
    var id: Int = UUID().hashValue
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
    
}
