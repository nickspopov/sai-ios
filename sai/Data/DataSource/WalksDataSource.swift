//
//  WalksDataSource.swift
//  sai
//
//  Created by Николай Попов on 02.09.2023.
//

import Foundation


protocol WalksDataSource {
    func get(by id: String) async throws -> Walk
    func get(from fromDate: Date?, to toDate: Date?, limit: Int?) async throws -> [Walk]
    func save(_ walk: Walk) async throws -> Walk
    func delete(_ walk: Walk) async throws
    
    func getOneDayAnalytic(for date: Date) async throws -> GetWalkDayActivity
    func getOneDayAnalyticCached(for date: Date) async -> GetWalkDayActivity?
    
    func getIntervalAnalyticByDay(fromDate: Date, toDate: Date) async throws -> GetWalkIntervalActivityByDay
    func getIntervalAnalyticByDayCached(fromDate: Date, toDate: Date) async -> GetWalkIntervalActivityByDay?
}
