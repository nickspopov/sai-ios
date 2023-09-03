//
//  CalendarEventsDataSource.swift
//  sai
//
//  Created by Николай Попов on 02.09.2023.
//

import Foundation


protocol CalendarEventsDataSource {
    func get(by id: String) async throws -> CalendarEvent
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent]
    func save(_ event: CalendarEvent) async throws -> CalendarEvent
    func update(_ event: CalendarEvent) async throws -> CalendarEvent
    func delete(_ calendarEvent: CalendarEvent) async throws
}
