//
//  WalkCoreData+Extension.swift
//  sai
//
//  Created by Николай Попов on 02.09.2023.
//

import Foundation
import CoreData

extension WalkCoreData {
    convenience init(context: NSManagedObjectContext, from walk: Walk) {
        self.init(context: context)
        self.id = walk.id
        self.startedAt = walk.startedAt
        self.finishedAt = walk.finishedAt
        self.walkHistory = walk.walkHistory.toJSON()
    }
    
    func toWalk() -> Walk {
        let walkHistory = WalkHistoryModel.fromJSON(self.walkHistory)
        return Walk(id: self.id, startedAt: self.startedAt, finishedAt: self.finishedAt, walkHistory: walkHistory)
    }
}
