//
//  SaiFastAPI+Extensions.swift
//  sai
//
//  Created by Николай Попов on 29.08.2023.
//

import Foundation
import SaiFastAPI

// MARK: - Walk analytics
extension GetWalkDayActivityQuery.Data.GetWalkDayActivity {
    var swiftDate: Date {
        return Date(fromISOString: self.date)
    }
}

extension GetWalkDayActivityQuery.Data.GetWalkDayActivity {
    func toSwiftModel() -> GetWalkDayActivity {
        return GetWalkDayActivity(totalDistance: self.totalDistance, totalDuration: self.totalDuration, avgSpeed: self.avgSpeed, avgPace: self.avgPace, date: self.swiftDate)
    }
}


extension GetWalkIntervalActivityByDayQuery.Data.GetWalkIntervalActivityByDay {
    func toSwiftModel() -> GetWalkIntervalActivityByDay {
        return GetWalkIntervalActivityByDay(totalDuration: self.totalDuration, totalDistance: self.totalDistance, items: self.items.map {
            GetWalkIntervalActivityItem(duration: $0.duration, date: Date(fromISOString: $0.date))
        })
    }
}

// MARK: - Walk CRUD
extension CreateWalkInput {
    init(from walk: Walk) {
        self.init(
            startedAt: walk.startedAt.ISO8601Format(), finishedAt: Date().ISO8601Format(), walkHistory: CreateWalkHistoryType(history: walk.walkHistory.history.map({ _historyItem in
                CreateWalkHistoryItemType(
                    latitude: _historyItem.latitude,
                    longitude: _historyItem.longitude,
                    timestamp: _historyItem.timestamp.ISO8601Format()
                )
            }))
        )
    }
}

extension CreateWalkMutation.Data.CreateWalk {
    func toSwiftModel() -> Walk {
        let history = self.walkHistory.history.map {
            Location(latitude: $0.latitude, longitude: $0.longitude, timestamp: Date(fromISOString: $0.timestamp))
        }
        return Walk(id: self.id, startedAt: Date(fromISOString: self.startedAt), finishedAt: Date(fromISOString: self.finishedAt), walkHistory: WalkHistoryModel(history: history)
        )
    }
}


extension GetWalksQuery.Data.GetWalk {
    func toSwiftModel() -> Walk {
        let history = self.walkHistory.history.map {
            Location(latitude: $0.latitude, longitude: $0.longitude, timestamp: Date(fromISOString: $0.timestamp))
        }
        return Walk(id: self.id, startedAt: Date(fromISOString: self.startedAt), finishedAt: Date(fromISOString: self.finishedAt), walkHistory: WalkHistoryModel(history: history)
        )
    }
}


extension GetWalkQuery.Data.GetWalk {
    func toSwiftModel() -> Walk {
        let history = self.walkHistory.history.map {
            Location(latitude: $0.latitude, longitude: $0.longitude, timestamp: Date(fromISOString: $0.timestamp))
        }
        return Walk(id: self.id, startedAt: Date(fromISOString: self.startedAt), finishedAt: Date(fromISOString: self.finishedAt), walkHistory: WalkHistoryModel(history: history)
        )
    }
}

// MARK: - CalendarEvents CRUD
extension CreateEventInput {
    init(from event: CalendarEvent) {
        self.init(title: event.title, notes: event.notes, startedAt: event.startedAt.ISO8601Format(), endedAt: event.endedAt.ISO8601Format(), type: .init(rawValue: event.type.rawValue))
    }
}

extension CreateEventMutation.Data.CreateEvent {
    func toSwiftModel() -> CalendarEvent {
        return CalendarEvent(id: self.id, title: self.title, notes: self.notes, startedAt: Date(fromISOString: self.startedAt), endedAt: Date(fromISOString: self.endedAt), type: CalendarEventType(rawValue: self.type.rawValue) ?? .other)
    }
}


extension GetEventsQuery.Data.GetEvent {
    func toSwiftModel() -> CalendarEvent {
        return CalendarEvent(id: self.id, title: self.title, notes: self.notes, startedAt: Date(fromISOString: self.startedAt), endedAt: Date(fromISOString: self.endedAt), type: CalendarEventType(rawValue: self.type.rawValue) ?? .other)
    }
}


// MARK: - User CRUD
extension GetMeQuery.Data.Me {
    func toSwiftModel() -> UserModel {
        let dogs: [DogModel] = self.dogs.map { DogModel(id: $0.id, name: $0.name, breed: $0.breed, sex: $0.sex, dateOfBirth: Date(fromISOString: $0.dateOfBirth)) }
        return UserModel(id: self.id, name: self.name, dogs: dogs)
    }
}
