//
//  Header.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI

var randomGrayColor = Color(uiColor: UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1))

struct CalendarWidget: View {
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            schedule
        }
        .padding(.top, 10)
        .padding(.horizontal, 16)
        .frame(minHeight: 164, maxHeight: 164, alignment: .leading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(24)
        .onAppear(perform: viewModel.onAppear)
        .overlay(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.15, green: 0.15, blue: 0.15).opacity(0), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.15, green: 0.15, blue: 0.15), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.5),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
        )
        
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            HStack {
                CalendarWidget()
                    .preferredColorScheme(.dark)
                    .padding(16)
                    .frame(width: geometry.size.width * 0.66)
            }
        }
    }
}

// MARK: - ViewModel
extension CalendarWidget {
    class ViewModel: ObservableObject {
        private let calendarEventsRepository: CalendarEventsRepositoryImpl = CalendarEventsRepositoryImpl.shared
        @Published var date: Date = Date()
        @Published var events: [CalendarEvent] = []
        
        func onAppear() {
            Task {
                do {
                    let _events = try await getEvents()
                    DispatchQueue.main.async {
                        self.events = _events
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        private func getEvents() async throws -> [CalendarEvent] {
            return try await calendarEventsRepository.get(from: fromDateFilter, to: toDateFilter)
        }
        
        private var fromDateFilter: Date {
            return date.startOfDay()
        }
        
        private var toDateFilter: Date {
            return date.endOfDay()
        }
    }
}

//MARK: - Schedule
extension CalendarWidget {
    private var scheduleItems: [CalendarEvent] {
                Array(viewModel.events.prefix(2))
//        [
//            CalendarEvent(title: "ssss", notes: "ssss", startedAt: Date(), endedAt: Date(), type: .food),
//            CalendarEvent(title: "ssss", notes: "ssss", startedAt: Date(), endedAt: Date(), type: .food)
//        ]
    }
    
    private var schedule: some View {
        VStack(alignment: .leading) {
            Typography("Plans (\(viewModel.events.count))", .medium(.six))
            Spacer()
                .frame(height: 38)
            if (scheduleItems.count > 0) {
                schedultItem(scheduleItems[0])
            }
            if(scheduleItems.count > 1) {
                schedultItem(scheduleItems[1])
                    .offset(y: 20)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    private func schedultItem(_ event: CalendarEvent) -> some View {
        return HStack(alignment: .center, spacing: 8) {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 6, height: 40)
                .foregroundColor(Color.warning)
            VStack(alignment: .leading) {
                Typography("\(event.startedAt.timeIn24HourFormat()) - \(event.endedAt.timeIn24HourFormat())", .regular(.seven))
                Spacer()
                    .frame(height: 4)
                Typography(event.title, .medium(.six))
                    .lineLimit(1)
            }
            Spacer()
        }
        .frame(height: 42)
    }
}
