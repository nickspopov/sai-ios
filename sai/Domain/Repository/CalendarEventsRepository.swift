//
//  CalendarEventsRepository.swift
//  sai
//
//  Created by Николай Попов on 02.09.2023.
//

import Foundation


protocol CalendarEventsRepository {
    func get(by id: String) async throws -> CalendarEvent
    func getCached(from fromDate: Date, to toDate: Date) async -> [CalendarEvent]
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent]
    func save(_ calendarEvent: CalendarEvent) async throws -> CalendarEvent
    func delete(_ calendarEvent: CalendarEvent) async throws
}

