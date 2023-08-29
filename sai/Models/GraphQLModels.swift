//
//  GraphQLModels.swift
//  sai
//
//  Created by Николай Попов on 29.08.2023.
//

import Foundation

struct GetWalkDayActivity {
    public var totalDistance: Double
    public var totalDuration: Double
    public var avgSpeed: Double
    public var avgPace: Double
    public var date: Date
    
    public var hours: Int {
        Int(totalDuration / 60 / 60)
    }
    
    public var minutes: Int {
        let _minutes = Int(totalDuration / 60)
        return _minutes == 60 ? 0 : _minutes
    }
    
    public var seconds: Int {
        Int(Double(totalDuration)
            .truncatingRemainder(dividingBy: 60))
    }
}
