//
//  CalendarEvent.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation

enum CalendarEventType: String, Codable, CaseIterable {
    case walking, grooming, food, vet, other
    
    static var allCases: [CalendarEventType] {
        return [.walking, .grooming, .food, .vet, .other]
    }
    
    var name: String {
        switch self {
        case .walking:
            return "Walking"
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
    var id: String = UUID().uuidString
    var title: String
    var notes: String
    var startedAt: Date
    var endedAt: Date
    var type: CalendarEventType
}
