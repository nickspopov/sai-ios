//
//  CalendarEventsRepository.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation


class CalendarEventsRepositoryImpl: CalendarEventsRepository {
    let calendarEventsGraphQLSource = CalendarEventsGraphQLImpl()
    
    func get(by id: String) async throws -> CalendarEvent {
        do {
            return try await calendarEventsGraphQLSource.get(by: id)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func getCached(from fromDate: Date, to toDate: Date) async -> [CalendarEvent] {
        return await calendarEventsGraphQLSource.getCached(from: fromDate, to: toDate)
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent] {
        do {
            return try await calendarEventsGraphQLSource.get(from: fromDate, to: toDate)
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func save(_ calendarEvent: CalendarEvent) async throws -> CalendarEvent {
        do {
            return try await calendarEventsGraphQLSource.save(calendarEvent)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func delete(_ calendarEvent: CalendarEvent) async throws {
        do {
            try await calendarEventsGraphQLSource.delete(calendarEvent)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    
    private init() {}
    static let shared = CalendarEventsRepositoryImpl()
}
