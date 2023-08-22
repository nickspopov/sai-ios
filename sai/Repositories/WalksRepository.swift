//
//  WalksRepository.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation

enum RepositoryError: Error {
    case notFound, somethingWentWrong
}

class WalksRepository {
    
    let walksDao = WalksDao.shared
    
    func getAll() -> [Walk] {
        if let result = try? walksDao.getAll() {
            return result
        } else {
            return []
        }
    }
    
    func get(by id: UUID) throws -> Walk {
        do {
            return try walksDao.get(by: id)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func get(from fromDate: Date, to toDate: Date) throws -> [Walk] {
        do {
            return try walksDao.get(from: fromDate, to: toDate)
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func save(_ walk: Walk) {
        walksDao.save(walk)
    }
    
    func delete(_ walk: Walk) {
        walksDao.delete(walk)
    }
    
    private init() {}
    
    static let shared = WalksRepository()
}
