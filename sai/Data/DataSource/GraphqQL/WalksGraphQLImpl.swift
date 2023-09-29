//
//  WalksGraphQLService.swift
//  sai
//
//  Created by Николай Попов on 31.08.2023.
//

import Foundation
import SaiFastAPI


class WalksGraphQLImpl: WalksDataSource {
    func getIntervalAnalyticByDay(fromDate: Date, toDate: Date) async throws -> GetWalkIntervalActivityByDay {
        let result = try await Network.shared.apollo.fetchSingle(query: GetWalkIntervalActivityByDayQuery(
            fromDate: fromDate.ISO8601Format(),
            toDate: toDate.ISO8601Format()
        ), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.getWalkIntervalActivityByDay.toDomain()
    }
    
    func getIntervalAnalyticByDayCached(fromDate: Date, toDate: Date) async -> GetWalkIntervalActivityByDay? {
        let result = await Network.shared.apollo.getCachedQuery(query: GetWalkIntervalActivityByDayQuery(
            fromDate: fromDate.ISO8601Format(),
            toDate: toDate.ISO8601Format()
        ))
        return result?.getWalkIntervalActivityByDay.toDomain()
    }
    
    func getOneDayAnalytic(for date: Date) async throws -> GetWalkDayActivity {
        let date = date.ISO8601Format()
        
        let result = try await Network.shared.apollo.fetchSingle(query: GetWalkDayActivityQuery( date: date ), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.getWalkDayActivity.toDomain()
    }
    
    func getOneDayAnalyticCached(for date: Date) async -> GetWalkDayActivity? {
        let date = date.ISO8601Format()
        
        let result = await Network.shared.apollo.getCachedQuery(query: GetWalkDayActivityQuery( date: date ))
        return result?.getWalkDayActivity.toDomain()
    }
    
    func get(by id: String) async throws -> Walk {
        let result = try await Network.shared.apollo.fetchSingle(query: GetWalkQuery(id: id), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.getWalk.toDomain()
    }
    
    func getCached(from fromDate: Date? = nil, to toDate: Date? = nil, limit: Int? = 10) async -> [Walk]? {
        let fromFilter: GraphQLNullable<DateTimeType> = fromDate != nil ? .some(fromDate!.ISO8601Format()) : .none
        let toFilter: GraphQLNullable<DateTimeType> = toDate != nil ? .some(toDate!.ISO8601Format()) : .none
        let limitFilter: GraphQLNullable<Int> = limit != nil ? .some(limit!) : .none
        
        let result = await Network.shared.apollo.getCachedQuery(query: GetWalksQuery(fromDate: fromFilter, toDate: toFilter, limit: limitFilter))
        return result?.getWalks.map { $0.toDomain() }
    }
    
    func get(from fromDate: Date? = nil, to toDate: Date? = nil, limit: Int? = 10) async throws -> [Walk] {
        let fromFilter: GraphQLNullable<DateTimeType> = fromDate != nil ? .some(fromDate!.ISO8601Format()) : .none
        let toFilter: GraphQLNullable<DateTimeType> = toDate != nil ? .some(toDate!.ISO8601Format()) : .none
        let limitFilter: GraphQLNullable<Int> = limit != nil ? .some(limit!) : .none
        
        let result = try await Network.shared.apollo.fetchSingle(query: GetWalksQuery(fromDate: fromFilter, toDate: toFilter, limit: limitFilter), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.getWalks.map { $0.toDomain() }
    }
    
    func save(_ walk: Walk) async throws -> Walk {
        let result = try await Network.shared.apollo.perform(mutation: CreateWalkMutation(input: CreateWalkInput(from: walk)))
        return result.createWalk.toDomain()
    }
    
    func delete(_ walk: Walk) async throws {
        throw NotImplementedError()
    }
}

