//
//  CalendarEvent.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation
import FirebaseFirestoreSwift

enum CalendarEventType: String, Codable {
    case walk, grooming, food, vet, other
}

struct CalendarEvent: Codable,Identifiable {
    @DocumentID var id: String?
    var title: String
    var notes: String
    var startedAt: Date
    var endedAt: Date
    var type: CalendarEventType
}
