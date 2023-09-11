//
//  TasksTab.swift
//  sai
//
//  Created by Николай Попов on 07.09.2023.
//

import SwiftUI
import Combine

struct TasksTab: View {
    var homeScreenTasksViewModel: HomeScreenTasksViewModel
    @StateObject private var viewModel: ViewModel
    
    init(homeScreenTasksViewModel: HomeScreenTasksViewModel) {
        self._viewModel = StateObject(wrappedValue: ViewModel(parentViewModel: homeScreenTasksViewModel))
        self.homeScreenTasksViewModel = homeScreenTasksViewModel
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
        TasksTab(homeScreenTasksViewModel: HomeScreenTasksViewModel(parentViewModel: HomeScreenViewModel()))
            .preferredColorScheme(.dark)
    }
}


extension TasksTab{
    class ViewModel: ObservableObject {
        var parentViewModel: HomeScreenTasksViewModel
        
        @Published var tasksList: [CalendarEvent] = []
        @Published var showCreateEventScreen: Bool = false
        
        private var subscribers: Set<AnyCancellable> = []
        
        init(parentViewModel: HomeScreenTasksViewModel) {
            self.parentViewModel = parentViewModel
            parentViewModel.$events.sink { newEvents in
                self.tasksList = newEvents
            }.store(in: &subscribers)
        }
        
        func onSheetDismiss() {
            parentViewModel.updateEventsList()
        }
    }
}
