//
//  CalendarEventsGraphQLService.swift
//  sai
//
//  Created by Николай Попов on 30.08.2023.
//

import Foundation
import Apollo
import SaiFastAPI

class CalendarEventsGraphQLImpl: CalendarEventsDataSource {
    func get(by id: String) async throws -> CalendarEvent {
        fatalError("not implemented")
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent] {
        do {
            let result = try await Network.shared.apollo.fetchSingle(query: GetEventsQuery(fromDate: fromDate.ISO8601Format(), toDate: toDate.ISO8601Format()), cachePolicy: .fetchIgnoringCacheData)
            return result.getEvents.map { $0.toSwiftModel() }
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func getCached(from fromDate: Date, to toDate: Date) async -> [CalendarEvent] {
        if let result = await Network.shared.apollo.getCachedQuery(query: GetEventsQuery(fromDate: fromDate.ISO8601Format(), toDate: toDate.ISO8601Format())) {
            return result.getEvents.map {$0.toSwiftModel()}
        } else {
            return []
        }
    }
    
    func save(_ event: CalendarEvent) async throws -> CalendarEvent {
        do {
            let mutation = CreateEventMutation(input: CreateEventInput(from: event))
            let result = try await Network.shared.apollo.perform(mutation: mutation)
            
            return result.createEvent.toSwiftModel()
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
