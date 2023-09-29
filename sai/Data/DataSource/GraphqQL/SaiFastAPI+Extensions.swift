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
        return self.date.toDomain()
    }
}

extension GetWalkDayActivityQuery.Data.GetWalkDayActivity {
    func toDomain() -> GetWalkDayActivity {
        return GetWalkDayActivity(totalDistance: self.totalDistance, totalDuration: self.totalDuration, avgSpeed: self.avgSpeed, avgPace: self.avgPace, date: self.swiftDate)
    }
}


extension GetWalkIntervalActivityByDayQuery.Data.GetWalkIntervalActivityByDay {
    func toDomain() -> GetWalkIntervalActivityByDay {
        return GetWalkIntervalActivityByDay(totalDuration: self.totalDuration, totalDistance: self.totalDistance, items: self.items.map {
            GetWalkIntervalActivityItem(duration: $0.duration, date: $0.date.toDomain())
        })
    }
}

// MARK: - Walk CRUD
extension CreateWalkInput {
    init(from walk: Walk) {
        self.init(
            startedAt: walk.startedAt.toGraphQL(), finishedAt: Date().toGraphQL(), walkHistory: CreateWalkHistoryType(history: walk.walkHistory.history.map({ _historyItem in
                CreateWalkHistoryItemType(
                    latitude: _historyItem.latitude,
                    longitude: _historyItem.longitude,
                    timestamp: _historyItem.timestamp.toGraphQL()
                )
            }))
        )
    }
}

extension CreateWalkMutation.Data.CreateWalk {
    func toDomain() -> Walk {
        let history = self.walkHistory.history.map {
            Location(latitude: $0.latitude, longitude: $0.longitude, timestamp: $0.timestamp.toDomain())
        }
        return Walk(id: self.id, startedAt: self.startedAt.toDomain(), finishedAt: self.finishedAt.toDomain(), walkHistory: WalkHistoryModel(history: history)
        )
    }
}


extension GetWalksQuery.Data.GetWalk {
    func toDomain() -> Walk {
        let history = self.walkHistory.history.map {
            Location(latitude: $0.latitude, longitude: $0.longitude, timestamp: $0.timestamp.toDomain())
        }
        return Walk(id: self.id, startedAt: self.startedAt.toDomain(), finishedAt: self.finishedAt.toDomain(), walkHistory: WalkHistoryModel(history: history)
        )
    }
}


extension GetWalkQuery.Data.GetWalk {
    func toDomain() -> Walk {
        let history = self.walkHistory.history.map {
            Location(latitude: $0.latitude, longitude: $0.longitude, timestamp: $0.timestamp.toDomain())
        }
        return Walk(id: self.id, startedAt: self.startedAt.toDomain(), finishedAt: self.finishedAt.toDomain(), walkHistory: WalkHistoryModel(history: history)
        )
    }
}

// MARK: - CalendarEvents CRUD
extension CreateEventInput {
    init(from event: CalendarEvent) {
        self.init(title: event.title, notes: event.notes, startedAt: event.startedAt.toGraphQL(), endedAt: event.endedAt.toGraphQL(), type: .init(rawValue: event.type.rawValue))
    }
}

extension CreateEventMutation.Data.CreateEvent {
    func toDomain() -> CalendarEvent {
        return CalendarEvent(id: self.id, title: self.title, notes: self.notes, startedAt: self.startedAt.toDomain(), endedAt: self.endedAt.toDomain(), type: CalendarEventType(rawValue: self.type.rawValue) ?? .other)
    }
}


extension GetEventsQuery.Data.GetEvent {
    func toDomain() -> CalendarEvent {
        return CalendarEvent(id: self.id, title: self.title, notes: self.notes, startedAt: self.startedAt.toDomain(), endedAt: self.endedAt.toDomain(), type: CalendarEventType(rawValue: self.type.rawValue) ?? .other)
    }
}

// MARK: - Dog
extension DogFragment {
    func toDomain() -> DogModel {
        return DogModel(id: self.id, name: self.name, breed: self.breed, sex: self.sex, dateOfBirth: self.dateOfBirth.toDomain())
    }
}

// MARK: - User
extension UserFragment {
    func toDomain() -> UserModel {
        let dogs: [DogModel] = self.dogs.map { $0.fragments.dogFragment.toDomain() }
        return UserModel(id: self.id, name: self.name, dogs: dogs)
    }
}

// MARK: - Communitues
extension CommunityFragment {
    func toDomain() -> CommunityModel {
        return CommunityModel(id: self.id, name: self.name, members: self.members.map({ $0.fragments.communityMemberFragment.toDomain() }), places: self.places.map({ $0.fragments.communityPlaceFragment.toDomain() }))
    }
}

extension CommunityPlaceFragment {
    func toDomain() -> CommunityPlace {
        return CommunityPlace(id: self.id, name: self.name, lat: self.lat, lon: self.lon)
    }
}

extension CommunityMemberLastCheckinFragment {
    func toDomain() -> LastCheckinModel {
        return LastCheckinModel(date: self.date.toDomain(), place: CommunityPlace(id: self.place.id, name: self.place.name))
    }
}

extension CommunityMemberFragment {
    func toDomain() -> CommunityMember {
        return CommunityMember(user: self.user.fragments.userFragment.toDomain(), lastCheckin: self.lastCheckin?.fragments.communityMemberLastCheckinFragment.toDomain())
    }
}


// MARK: - Utils
extension SaiFastAPI.DateTimeType {
    func toDomain() -> Date {
        return Date(fromISOString: self)
    }
}

extension Date {
    func toGraphQL() -> SaiFastAPI.DateTimeType {
        return self.ISO8601Format()
    }
}
