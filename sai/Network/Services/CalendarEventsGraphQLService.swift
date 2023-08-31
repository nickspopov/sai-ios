//
//  CalendarEventsGraphQLService.swift
//  sai
//
//  Created by Николай Попов on 30.08.2023.
//

import Foundation
import Apollo
import SaiFastAPI

class CalendarEventsGraphQL: CalendarEventsDaoProtocol {
    func get(by id: String) async throws -> CalendarEvent {
        fatalError("not implemented")
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent] {
        do {
            let result = try await Network.shared.apollo.fetchSingle(query: GetEventsQuery(fromDate: fromDate.ISO8601Format(), toDate: toDate.ISO8601Format()), cachePolicy: .fetchIgnoringCacheData)
            return result.getEvents.map { graphQLItem in
                return CalendarEvent(id: graphQLItem.id, title: graphQLItem.title, notes: graphQLItem.notes, startedAt: Date(fromISOString: graphQLItem.startedAt), endedAt: Date(fromISOString: graphQLItem.endedAt), type: CalendarEventType.init(rawValue: graphQLItem.type.rawValue) ?? .other)
            }
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func getCached(from fromDate: Date, to toDate: Date) async -> [CalendarEvent] {
        if let result = await Network.shared.apollo.getCachedQuery(query: GetEventsQuery(fromDate: fromDate.ISO8601Format(), toDate: toDate.ISO8601Format())) {
            return result.getEvents.map { graphQLItem in
                return CalendarEvent(id: graphQLItem.id, title: graphQLItem.title, notes: graphQLItem.notes, startedAt: Date(fromISOString: graphQLItem.startedAt), endedAt: Date(fromISOString: graphQLItem.endedAt), type: CalendarEventType.init(rawValue: graphQLItem.type.rawValue) ?? .other)
            }
        } else {
            return []
        }
    }
    
    func save(_ event: CalendarEvent) async throws -> CalendarEvent {
        do {
            let mutation = CreateEventMutation(input: CreateEventInput(title: event.title, notes: event.notes, startedAt: event.startedAt.ISO8601Format(), endedAt: event.endedAt.ISO8601Format(), type: .init(rawValue: event.type.rawValue)))
            let result = try await Network.shared.apollo.perform(mutation: mutation)
            
            let resultData = result.createEvent
            
            return CalendarEvent(id: resultData.id, title: resultData.title, notes: resultData.notes, startedAt: Date(fromISOString: resultData.startedAt), endedAt: Date(fromISOString: resultData.endedAt), type: CalendarEventType.init(rawValue: resultData.type.rawValue) ?? .other)
        } catch {
            print(error)
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func update(_ event: CalendarEvent) async throws -> CalendarEvent {
        fatalError("not implemented")
    }
    
    func delete(_ calendarEvent: CalendarEvent) async throws {
        fatalError("not implemented")
    }
    
    
}
