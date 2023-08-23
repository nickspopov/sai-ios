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
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [Walk] {
        let fromPredicate = NSPredicate(format: "startedAt >= %@", fromDate as CVarArg)
        let toPredicate = NSPredicate(format: "startedAt <= %@", toDate as CVarArg)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let fetchRequest: NSFetchRequest<WalkCoreData> = WalkCoreData.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.map {Walk.fromCoreData(coreData: $0)}
        } catch {
            print(error)
            throw DaoError.somethingWrong
        }
    
    }
    
    func save(_ walk: Walk) async throws -> Walk {
        let walkCoreData = walk.toCoreData(context: viewContext)
        try? viewContext.save()
        return walk
    }
    
    func delete(_ walk: Walk) async throws {
        viewContext.delete(walk.toCoreData(context: viewContext))
        try? viewContext.save()
    }
    
    private init() {}
    
    static let shared = WalksDao()
}
