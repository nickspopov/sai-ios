//
//  ContentView.swift
//  sai
//
//  Created by Николай Попов on 21.08.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var navigationController = NavigationController()

    var body: some View {
        NavigationStack(path: $navigationController.stack) {
            ZStack {
                HomeScreen()
                    .environmentObject(navigationController)
            }
            .navigationDestination(for: Route.self) { currentRoute in
                switch currentRoute {
                case .testScreen:
                    TestScreen()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
