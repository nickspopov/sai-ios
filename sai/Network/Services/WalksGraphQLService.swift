//
//  WalksGraphQLService.swift
//  sai
//
//  Created by Николай Попов on 31.08.2023.
//

import Foundation
import SaiFastAPI


class WalksGraphQLService: WalksDaoProtocol {
    func getIntervalAnalyticByDay(fromDate: Date, toDate: Date) async throws -> GetWalkIntervalActivityByDay {
        let result = try await Network.shared.apollo.fetchSingle(query: GetWalkIntervalActivityByDayQuery(
            fromDate: fromDate.ISO8601Format(),
            toDate: toDate.ISO8601Format()
        ), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.getWalkIntervalActivityByDay.toSwiftModel()
    }
    
    func getIntervalAnalyticByDayCached(fromDate: Date, toDate: Date) async -> GetWalkIntervalActivityByDay? {
        let result = await Network.shared.apollo.getCachedQuery(query: GetWalkIntervalActivityByDayQuery(
            fromDate: fromDate.ISO8601Format(),
            toDate: toDate.ISO8601Format()
        ))
        return result?.getWalkIntervalActivityByDay.toSwiftModel()
    }
    
    func getOneDayAnalytic(for date: Date) async throws -> GetWalkDayActivity {
        let date = date.ISO8601Format()
        let result = try await Network.shared.apollo.fetchSingle(query: GetWalkDayActivityQuery(
            date: date
        ), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.getWalkDayActivity.toSwiftModel()
    }
    
    func getOneDayAnalyticCached(for date: Date) async -> GetWalkDayActivity? {
        let date = date.ISO8601Format()
        let result = await Network.shared.apollo.getCachedQuery(query: GetWalkDayActivityQuery(
            date: date
        ))
        return result?.getWalkDayActivity.toSwiftModel()
    }
    
    func get(by id: String) async throws -> Walk {
        throw NotImplementedError()
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [Walk] {
        throw NotImplementedError()
    }
    
    func save(_ walk: Walk) async throws -> Walk {
        let result = try await Network.shared.apollo.perform(mutation: CreateWalkMutation(
            input: CreateWalkInput(
                startedAt: walk.startedAt.ISO8601Format(), finishedAt: Date().ISO8601Format(), walkHistory: CreateWalkHistoryType(history: walk.walkHistory.history.map({ _historyItem in
                    CreateWalkHistoryItemType(
                        latitude: _historyItem.latitude,
                        longitude: _historyItem.longitude,
                        timestamp: _historyItem.timestamp.ISO8601Format()
                    )
                }))
            )
        ))
        return result.createWalk.toSwiftModel()
    }
    
    func delete(_ walk: Walk) async throws {
        throw NotImplementedError()
    }
}

