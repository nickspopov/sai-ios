//
//  CalendarScreenViewModel.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import Foundation
import Combine

class CalendarScreenViewModel: ObservableObject {
    private let calendarEventsRepository: CalendarEventsRepository = CalendarEventsRepository.shared
    
    @Published var selectedDate: Date = Date().startOfDay()
    @Published var daysArray: [Date] = []
    @Published var events: [CalendarEvent] = []
    
    
    init() {
        $selectedDate.sink { selectedDate in
            self.getEvents(for: selectedDate)
        }.store(in: &subscribers)
    }
    
    func onAppear() {
        calcDatesArray()
    }
    
    func onDateSelected(date: Date) {
        selectedDate = date
    }
    
    private func getEvents(for date: Date) -> Void {
        Task {
            if let events = try? await calendarEventsRepository.get(from: date.startOfDay(), to: date.endOfDay()) {
                DispatchQueue.main.async {
                    self.events = events
                }
            } else {
                DispatchQueue.main.async {
                    self.events = []
                }
            }
        }
    }
    
    // MARK: - Private
    private func calcDatesArray(direction: Int = 0) {
        // Empty case
        if(self.daysArray.isEmpty) {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                var tempArray: [Date] = []
                let calendar = Calendar.current
                
                for i in 1...30 {
                    if let nextDate = calendar.date(byAdding: .day, value: -i, to: self?.selectedDate ?? Date()) {
                        tempArray.append(nextDate)
                    }
                }
                tempArray.reverse()
                for i in 0...10 {
                    if let nextDate = calendar.date(byAdding: .day, value: i, to: self?.selectedDate ?? Date()) {
                        tempArray.append(nextDate)
                    }
                }
                
                DispatchQueue.main.async {
                    self?.daysArray = tempArray
                }
            }
            return
        }
        
        if(direction == 1) {
            // Calc next year
        }
        
        if(direction == 2) {
            // Calc prev year
        }
    }
    
    private var subscribers: Set<AnyCancellable> = []
}
