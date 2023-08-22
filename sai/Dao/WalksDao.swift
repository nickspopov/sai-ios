//
//  WalksDao.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation
import CoreData

enum DaoError: Error {
    case notFound
    case somethingWrong
}

protocol WalksDaoProtocol {
    func getAll() throws -> [Walk]
    func get(by id: UUID) throws -> Walk
    func get(from fromDate: Date, to toDate: Date) throws -> [Walk]
    func save(_ walk: Walk)
    func delete(_ walk: Walk)
}

class WalksDao: WalksDaoProtocol {
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    func getAll() throws -> [Walk] {
        let fetchRequest: NSFetchRequest<WalkCoreData> = WalkCoreData.fetchRequest()
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.map {Walk.fromCoreData(coreData: $0)}
        } catch {
            print(error)
            throw DaoError.somethingWrong
        }
    }
    
    func get(by id: UUID) throws -> Walk {
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
    
    func get(from fromDate: Date, to toDate: Date) throws -> [Walk] {
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
    
    func save(_ walk: Walk) {
        let walkCoreData = walk.toCoreData(context: viewContext)
        try? viewContext.save()
    }
    
    func delete(_ walk: Walk) {
        viewContext.delete(walk.toCoreData(context: viewContext))
        try? viewContext.save()
    }
    
    private init() {}
    
    static let shared = WalksDao()
}
