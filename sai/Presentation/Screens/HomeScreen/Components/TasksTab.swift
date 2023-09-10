//
//  TasksTab.swift
//  sai
//
//  Created by Николай Попов on 07.09.2023.
//

import SwiftUI
import Combine

struct TasksTab: View {
    var homeScreenViewModel: HomeScreenViewModel
    @StateObject private var viewModel: ViewModel
    
    init(homeScreenViewModel: HomeScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: ViewModel(parentViewModel: homeScreenViewModel))
        self.homeScreenViewModel = homeScreenViewModel
    }
    
    var body: some View {
        VStack(spacing: 4) {
            CreateNewButton(title: "Create new", action: { viewModel.showCreateEventScreen = true })
                .sheet(isPresented: $viewModel.showCreateEventScreen, onDismiss: {
                    viewModel.onSheetDismiss()
                }) {
                    CreateEventScreen()
                }
            ScrollView(showsIndicators: false) {
                // To prevent collaps width animation
                VStack{}.frame(maxWidth: .infinity)
                VStack(spacing: 4) {
                    ForEach(Array(zip(viewModel.tasksList.indices, viewModel.tasksList)), id: \.1.id) { index, _taskItem in
                        TasksTabItem(task: _taskItem, color: .init(fromIndex: index))
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct TasksTab_Previews: PreviewProvider {
    static var previews: some View {
        TasksTab(homeScreenViewModel: HomeScreenViewModel())
            .preferredColorScheme(.dark)
    }
}


extension TasksTab{
    class ViewModel: ObservableObject {
        var parentViewModel: HomeScreenViewModel
        
        @Published var tasksList: [CalendarEvent] = []
        @Published var showCreateEventScreen: Bool = false
        
        private var subscribers: Set<AnyCancellable> = []
        
        init(parentViewModel: HomeScreenViewModel) {
            self.parentViewModel = parentViewModel
            parentViewModel.$selectedDate.sink { selectedDate in
                self.getCachedEvents(for: selectedDate)
                self.getEvents(for: selectedDate)
            }.store(in: &subscribers)
        }
        
        func onSheetDismiss() {
            getEvents(for: parentViewModel.selectedDate)
        }
        
        // MARK: - Private
        private let calendarEventsRepository: CalendarEventsRepositoryImpl = CalendarEventsRepositoryImpl.shared
        
        private func getCachedEvents(for date: Date) -> Void {
            Task {
                let events = await calendarEventsRepository.getCached(from: date.startOfDay(), to: date.endOfDay())
                DispatchQueue.main.async {
                    withAnimation {
                        self.tasksList = events
                    }
                }
            }
        }
        
        private func getEvents(for date: Date) -> Void {
            Task {
                if let events = try? await calendarEventsRepository.get(from: date.startOfDay(), to: date.endOfDay()) {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.tasksList = events
                        }
                    }
                }
            }
        }
    }
}
