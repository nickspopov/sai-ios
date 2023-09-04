//
//  WalksRepository.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation


class WalksRepositoryImpl: WalksRepository {
    
    private let walksDao: WalksDataSource = WalksDBImpl.shared
    private let walksGraphQLService: WalksDataSource = WalksGraphQLImpl()
    
    // MARK: - Analytics
    
    func getIntervalAnalyticByDay(fromDate: Date, toDate: Date) async throws -> GetWalkIntervalActivityByDay {
        return try await walksGraphQLService.getIntervalAnalyticByDay(fromDate: fromDate, toDate: toDate)
    }
    
    func getIntervalAnalyticByDayCached(fromDate: Date, toDate: Date) async -> GetWalkIntervalActivityByDay? {
        return await walksGraphQLService.getIntervalAnalyticByDayCached(fromDate: fromDate, toDate: toDate)
    }
    
    func getOneDayAnalytic(for date: Date) async throws -> GetWalkDayActivity {
        return try await walksGraphQLService.getOneDayAnalytic(for: date)
    }
    
    func getOneDayAnalyticCached(for date: Date) async -> GetWalkDayActivity? {
        return await walksGraphQLService.getOneDayAnalyticCached(for: date)
    }
    
    // MARK: - CRUD
    func get(by id: String) async throws -> Walk {
        return try await walksGraphQLService.get(by: id)
    }
    
    func getLast() async throws -> Walk? {
        return try await walksGraphQLService.get(from: nil, to: nil, limit: 1).first
    }
    
    func save(_ walk: Walk) async throws -> Walk {
        return try await walksGraphQLService.save(walk)
    }
    
    func delete(_ walk: Walk) async throws {
        do {
            try await walksDao.delete(walk)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    private init() {}
    
    static let shared = WalksRepositoryImpl()
}






////
////  WalksRepository.swift
////  sai
////
////  Created by Николай Попов on 22.08.2023.
////
//
//import Foundation
//
//enum RepositoryError: Error {
//    case notFound, somethingWentWrong
//}
//
//class WalksRepository {
//
//    let walksDao = WalksDao.shared
//    let walksFirestore = WalksFirestore.shared
//
//
//    func getCached() throws -> [Walk] {
//        do {
//            return try walksDao.getAll()
//        } catch {
//            throw RepositoryError.somethingWentWrong
//        }
//    }
//
//    func getRemote() async throws -> [Walk] {
//        do {
//            let walks = try await walksFirestore.getAll()
//            if let cachedWalks = try? getCached() {
//                sync(cache: cachedWalks, remote: walks)
//            }
//            return walks
//        } catch {
//            throw RepositoryError.somethingWentWrong
//        }
//    }
//
//
////    func getAll() async throws -> [Walk] {
//////        if let firebaseWalks = try? await walksFirestore.getAll() {
//////            for firebaseWalk in firebaseWalks {
//////                walksDao.save(firebaseWalk)
//////            }
//////        }
////        if let result = try? walksDao.getAll() {
////            return result
////        } else {
////            return []
////        }
////    }
//
//    func get(by id: UUID) throws -> Walk {
//        do {
//            return try walksDao.get(by: id)
//        } catch DaoError.notFound {
//            throw RepositoryError.notFound
//        } catch {
//            throw RepositoryError.somethingWentWrong
//        }
//    }
//
//    func get(from fromDate: Date, to toDate: Date) throws -> [Walk] {
//        do {
//            return try walksDao.get(from: fromDate, to: toDate)
//        } catch {
//            throw RepositoryError.somethingWentWrong
//        }
//    }
//
//    func save(_ walk: Walk) {
//        walksDao.save(walk)
//    }
//
//    func delete(_ walk: Walk) {
//        walksDao.delete(walk)
//    }
//
//    private func sync(cache: [Walk], remote: [Walk]) {
//        for cachedItem in cache {
//            if let remoteItem = remote.first { $0.id == cachedItem.id } {
//
//            } else {
//
//            }
//
//        }
//    }
//
//    private init() {}
//
//    static let shared = WalksRepository()
//}
