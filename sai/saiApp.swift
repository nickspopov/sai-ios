//
//  saiApp.swift
//  sai
//
//  Created by Николай Попов on 21.08.2023.
//

import SwiftUI

@main
struct saiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
