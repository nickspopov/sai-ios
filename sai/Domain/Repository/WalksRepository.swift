//
//  WalksRepository.swift
//  sai
//
//  Created by Николай Попов on 02.09.2023.
//

import Foundation


protocol WalksRepository {
    // MARK: - Analytics
    func getIntervalAnalyticByDay(fromDate: Date, toDate: Date) async throws -> GetWalkIntervalActivityByDay
    func getIntervalAnalyticByDayCached(fromDate: Date, toDate: Date) async -> GetWalkIntervalActivityByDay?
    func getOneDayAnalytic(for date: Date) async throws -> GetWalkDayActivity
    func getOneDayAnalyticCached(for date: Date) async -> GetWalkDayActivity?
    
    // MARK: - CRUD
    func get(by id: String) async throws -> Walk
    func getLast() async throws -> Walk?
    func save(_ walk: Walk) async throws -> Walk
    func delete(_ walk: Walk) async throws
}
