//
//  DaoProtocols.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import Foundation


protocol WalksDaoProtocol {
    func getAll() async throws -> [Walk]
    func get(by id: String) async throws -> Walk
    func get(from fromDate: Date, to toDate: Date) async throws -> [Walk]
    func save(_ walk: Walk) async throws -> Walk
    func delete(_ walk: Walk) async throws
}

protocol CalendarEventsDaoProtocol {
    func get(by id: String) async throws -> CalendarEvent
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent]
    func save(_ event: CalendarEvent) async throws -> CalendarEvent
    func update(_ event: CalendarEvent) async throws -> CalendarEvent
    func delete(_ calendarEvent: CalendarEvent) async throws
}
