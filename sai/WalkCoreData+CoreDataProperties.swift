//
//  WalkCoreData+CoreDataProperties.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//
//

import Foundation
import CoreData


public class WalkCoreData: NSManagedObject {}

extension WalkCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalkCoreData> {
        return NSFetchRequest<WalkCoreData>(entityName: "Walk")
    }

    @NSManaged public var id: String
    @NSManaged public var startedAt: Date
    @NSManaged public var finishedAt: Date
    @NSManaged public var walkHistory: String
}

extension WalkCoreData : Identifiable {

}
