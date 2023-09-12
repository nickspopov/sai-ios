//
//  SomeScreenTasksViewModel.swift
//  sai
//
//  Created by Николай Попов on 11.09.2023.
//

import Foundation
import Combine
import SwiftUI

class HomeScreenTasksViewModel: ObservableObject {
    var homeScreenProvider: HomeScreenProvider
    
    private let calendarEventsRepository: CalendarEventsRepositoryImpl = CalendarEventsRepositoryImpl.shared
    
    @Published var events: [CalendarEvent] = []
    
    private var subscribers: Set<AnyCancellable> = []
    private var date: Date = Date()
    
    init(homeScreenProvider: HomeScreenProvider) {
        self.homeScreenProvider = homeScreenProvider
        homeScreenProvider.$selectedDate.sink { selectedDate in
            self.date = selectedDate
            self.updateEventsList()
        }.store(in: &subscribers)
    }
    
    func updateEventsList() {
        getCachedEvents(for: date)
        getEvents(for: date)
    }
    
    private func getCachedEvents(for date: Date) -> Void {
        Task {
            let events = await calendarEventsRepository.getCached(from: date.startOfDay(), to: date.endOfDay())
            DispatchQueue.main.async {
                withAnimation {
                    self.events = events
                }
            }
        }
    }
    
    private func getEvents(for date: Date) -> Void {
        Task {
            if let events = try? await calendarEventsRepository.get(from: date.startOfDay(), to: date.endOfDay()) {
                DispatchQueue.main.async {
                    withAnimation {
                        self.events = events
                    }
                }
            }
        }
    }
}
