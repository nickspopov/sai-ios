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
        HStack(alignment: .center, spacing: 24) {
            dateRectangle
            schedule
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 152, maxHeight: 152, alignment: .leading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(12)
        .onAppear(perform: viewModel.onAppear)
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWidget()
            .preferredColorScheme(.dark)
            .padding(16)
    }
}

// MARK: - ViewModel
extension CalendarWidget {
    class ViewModel: ObservableObject {
        private let calendarEventsRepository: CalendarEventsRepository = CalendarEventsRepository.shared
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


// MARK: - Date Rectangle
extension CalendarWidget {
    private var dateRectangle: some View {
        VStack(alignment: .leading) {
            Typography(viewModel.date.format(format: "MMM dd"), .semibold(.three))
            Spacer()
            VStack(alignment: .leading, spacing: 0){
                Typography(viewModel.date.dayOfWeek(), .regular(.eight))
                    .frame(height: 20)
                Typography("\(viewModel.events.count) reminders", .regular(.eight))
                    .frame(height: 20)
            }
            .foregroundColor(randomGrayColor)
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .frame(minWidth: 142, maxWidth: 142, maxHeight: .infinity, alignment: .leading)
        .background(
          LinearGradient(
            stops: [
              Gradient.Stop(color: Color(red: 33, green: 58, blue: 125), location: 0.00),
              Gradient.Stop(color: Color(red: 237, green: 185, blue: 108), location: 1),
            ],
            startPoint: UnitPoint(x: 0, y: 1),
            endPoint: UnitPoint(x: 1, y: 0)
          )
        )
        .cornerRadius(8)
    }
    
}

//MARK: - Schedule
extension CalendarWidget {
    private var schedule: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
                .frame(height: 6)
            Typography("Upcoming", .regular(.eight))
                .foregroundColor(randomGrayColor)
            ForEach(viewModel.events.prefix(2)) { event in
                schedultItem(event)
            }
            Spacer()
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
                .frame(width: 2, height: 31)
                .foregroundColor(Color.warning)
            VStack(alignment: .leading) {
                Typography(event.title, .semibold(.seven))
                    .lineLimit(1)
                Spacer()
                    .frame(height: 4)
                Typography("\(event.startedAt.timeIn24HourFormat()) - \(event.endedAt.timeIn24HourFormat())", .regular(.eight))
                    .foregroundColor(Color(uiColor: UIColor(red: 0.64, green: 0.68, blue: 0.69, alpha: 1)))
            }
            Spacer()
        }
        .frame(height: 42)
    }
}
