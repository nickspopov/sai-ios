//
//  WalksDao.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation
import CoreData

class WalksDao: WalksDaoProtocol {
    private let viewContext = PersistenceController.shared.container.viewContext
    
    func getAll() async throws -> [Walk] {
        let fetchRequest: NSFetchRequest<WalkCoreData> = WalkCoreData.fetchRequest()
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.map {Walk.fromCoreData(coreData: $0)}
        } catch {
            print(error)
            throw DaoError.somethingWrong
        }
    }
    
    func get(by id: String) async throws -> Walk {
        let fetchRequest: NSFetchRequest<WalkCoreData> = WalkCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let walk = result.first {
                return Walk.fromCoreData(coreData: walk)
            } else {
                throw DaoError.notFound
            }
        } catch {
            print(error)
            throw DaoError.somethingWrong
        }
    }
    
    func get(from fromDate: Date? = nil, to toDate: Date? = nil, limit: Int? = 10) async throws -> [Walk] {
//        let fromPredicate = NSPredicate(format: "startedAt >= %@", fromDate as CVarArg)
//        let toPredicate = NSPredicate(format: "startedAt <= %@", toDate as CVarArg)
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
//
//        let fetchRequest: NSFetchRequest<WalkCoreData> = WalkCoreData.fetchRequest()
//        fetchRequest.predicate = predicate
//
//        do {
//            let result = try viewContext.fetch(fetchRequest)
//            return result.map {Walk.fromCoreData(coreData: $0)}
//        } catch {
//            print(error)
            throw NotImplementedError()
//        }
    
    }
    
    func save(_ walk: Walk) async throws -> Walk {
        let _ = walk.toCoreData(context: viewContext)
        try? viewContext.save()
        return walk
    }
    
    func delete(_ walk: Walk) async throws {
        viewContext.delete(walk.toCoreData(context: viewContext))
        try? viewContext.save()
    }
    
    func getOneDayAnalytic(for date: Date) async throws -> GetWalkDayActivity {
        throw NotImplementedError()
    }
    
    func getOneDayAnalyticCached(for date: Date) async -> GetWalkDayActivity? {
        return nil
    }
    
    func getIntervalAnalyticByDay(fromDate: Date, toDate: Date) async throws -> GetWalkIntervalActivityByDay {
        throw NotImplementedError()
    }
    
    func getIntervalAnalyticByDayCached(fromDate: Date, toDate: Date) async -> GetWalkIntervalActivityByDay? {
        return nil
    }
    
    private init() {}
    
    static let shared = WalksDao()
}
