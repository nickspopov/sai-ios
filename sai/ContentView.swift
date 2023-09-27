//
//  ContentView.swift
//  sai
//
//  Created by Николай Попов on 21.08.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var navigationController: NavigationController
    @StateObject var viewModel: ViewModel
    
    init() {
        let navigationController = NavigationController()
        let viewModel = ViewModel(navigationController: navigationController)
        _viewModel = StateObject(wrappedValue: viewModel)
        _navigationController = ObservedObject(wrappedValue: navigationController)
    }
    
    var body: some View {
        NavigationStack(path: $navigationController.stack) {
            ZStack {
                LoadingAppView()
            }
            .navigationDestination(for: Route.self) { currentRoute in
                switch currentRoute {
                case .signInScreen: SignInScreen().environmentObject(navigationController)
                case .homeScreen: HomeScreen().environmentObject(navigationController)
                case .calendarScreen: CalendarScreen().environmentObject(navigationController)
                case .walksScreen: WalksScreen().environmentObject(navigationController)
                case .petTimeScreen: PetTimeScreen().environmentObject(navigationController)
                }
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        var navigationController: NavigationController
        @Published var isLoggedIn: Bool? = nil
        
        init(navigationController: NavigationController) {
            self.navigationController = navigationController
        }
        
        func onAppear() {
            DispatchQueue.main.async {
                if (AuthServiceFirebaseImpl.shared.checkAuthStatusOptimistic() == true) {
                    self.navigationController.push(to: .homeScreen)
                    self.isLoggedIn = true
                } else {
                    self.navigationController.push(to: .signInScreen)
                    self.isLoggedIn = false
                }
            }
        }
    }
}
