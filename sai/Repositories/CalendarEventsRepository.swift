//
//  CalendarEventsRepository.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation


class CalendarEventsRepository {
    let calendarEventsDao: CalendarEventsDaoProtocol = CalendarEventsFirestore.shared
    
    func get(by id: String) async throws -> CalendarEvent {
        do {
            return try await calendarEventsDao.get(by: id)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent] {
        do {
            return try await calendarEventsDao.get(from: fromDate, to: toDate)
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func save(_ calendarEvent: CalendarEvent) async throws -> CalendarEvent {
        do {
            return try await calendarEventsDao.save(calendarEvent)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func delete(_ calendarEvent: CalendarEvent) async throws {
        do {
            try await calendarEventsDao.delete(calendarEvent)
        } catch DaoError.notFound {
            throw RepositoryError.notFound
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    
    private init() {}
    static let shared = CalendarEventsRepository()
}
