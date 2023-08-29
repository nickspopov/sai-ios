//
//  SaiFastAPI+Extensions.swift
//  sai
//
//  Created by Николай Попов on 29.08.2023.
//

import Foundation
import SaiFastAPI


extension GetWalkDayActivityQuery.Data.GetWalkDayActivity {
    var swiftDate: Date {
        return Date(fromISOString: self.date)
    }
}

extension GetWalkDayActivityQuery.Data.GetWalkDayActivity {
    func toSwiftModel() -> GetWalkDayActivity {
        return GetWalkDayActivity(totalDistance: self.totalDistance, totalDuration: self.totalDuration, avgSpeed: self.avgSpeed, avgPace: self.avgPace, date: self.swiftDate)
    }
}

