//
//  CalendarEventsRepository.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation


class CalendarEventsRepository {
    let calendarEventsGraphQLService = CalendarEventsGraphQL()
    
    func get(by id: String) async throws -> CalendarEvent {
        do {
            return try await calendarEventsGraphQLService.get(by: id)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func getCached(from fromDate: Date, to toDate: Date) async -> [CalendarEvent] {
        return await calendarEventsGraphQLService.getCached(from: fromDate, to: toDate)
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent] {
        do {
            return try await calendarEventsGraphQLService.get(from: fromDate, to: toDate)
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func save(_ calendarEvent: CalendarEvent) async throws -> CalendarEvent {
        do {
            return try await calendarEventsGraphQLService.save(calendarEvent)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func delete(_ calendarEvent: CalendarEvent) async throws {
        do {
            try await calendarEventsGraphQLService.delete(calendarEvent)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    
    private init() {}
    static let shared = CalendarEventsRepository()
}
