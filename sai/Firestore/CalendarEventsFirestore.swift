//
//  CalendarEventsDao.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CalendarEventsFirestore: CalendarEventsDaoProtocol {
    private let db = Firestore.firestore()
    
    func get(by id: String) async throws -> CalendarEvent {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<CalendarEvent, Error>) -> Void in
            db.collection(collection).document(id).getDocument { (document, error) in
                if let error = error {
                    continuation.resume(throwing: DaoError.notFound)
                } else {
                    do {
                        let calendarEvent = try document!.data(as: CalendarEvent.self)
                        continuation.resume(returning: calendarEvent)
                    }
                    catch {
                        continuation.resume(throwing: DaoError.somethingWrong)
                    }
                }
            }
        })
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [CalendarEvent] {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[CalendarEvent], Error>) -> Void in
            db.collection(collection).whereField("startedAt", isLessThan: toDate).whereField("startedAt", isGreaterThan: fromDate).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    continuation.resume(throwing: DaoError.somethingWrong)
                } else {
                    var calendarEvents: [CalendarEvent] = []
                    for document in querySnapshot!.documents {
                        do {
                            let calendarEvent = try document.data(as: CalendarEvent.self)
                            calendarEvents.append(calendarEvent)
                        }
                        catch {
                            continuation.resume(throwing: DaoError.somethingWrong)
                        }
                    }
                    continuation.resume(returning: calendarEvents)
                }
            }
        })
    }
    
    func save(_ event: CalendarEvent) async throws -> CalendarEvent {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<CalendarEvent, Error>) -> Void in
            if let result = try? db.collection(collection).addDocument(from: event) {
                continuation.resume(returning: event)
            } else {
                continuation.resume(throwing: DaoError.somethingWrong)
            }
        })
    }
    
    func update(_ event: CalendarEvent) async throws -> CalendarEvent {
        fatalError("event update not implemented")
    }
    
    func delete(_ calendarEvent: CalendarEvent) async throws {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Void, Error>) -> Void in
            db.collection(collection).document(calendarEvent.id!).delete() { err in
                if let err = err {
                    continuation.resume(throwing: DaoError.somethingWrong)
                } else {
                    print("Document successfully removed!")
                }
            }
        })
    }
    
    
    private let collection: String = "calendarEvents"
    
    private init() {}
    static let shared = CalendarEventsFirestore()
}
