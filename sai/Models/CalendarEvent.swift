//
//  CalendarEvent.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation
import FirebaseFirestoreSwift

enum CalendarEventType: String, Codable, CaseIterable {
    case walk, grooming, food, vet, other
    
    static var allCases: [CalendarEventType] {
        return [.walk, .grooming, .food, .vet, .other]
    }
    
    var name: String {
        switch self {
        case .walk:
            return "Walk"
        case .grooming:
            return "Grooming"
        case .food:
            return "Food"
        case .vet:
            return "Vet"
        case .other:
            return "Other"
        }
    }
    
}

struct CalendarEvent: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var title: String
    var notes: String
    var startedAt: Date
    var endedAt: Date
    var type: CalendarEventType
}
