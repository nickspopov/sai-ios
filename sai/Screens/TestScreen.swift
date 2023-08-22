//
//  TestScreen.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import SwiftUI
import CoreData

struct TestScreen: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Text("Active walk: \(viewModel.activeWalk?.distance ?? 666.666)")
            Text("Duration: \(viewModel.timer)")
            Button("Start") {
                viewModel.start()
            }
            Button("Stop") {
                viewModel.stop()
            }
            List(viewModel.walks) { walk in
                Text("\(walk.id.uuidString)")
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

struct TestScreen_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
    }
}


extension TestScreen {
    class ViewModel: ObservableObject {
        private var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        private var activeWalkService = ActiveWalkService.shared
        
        @Published var walks: [Walk] = []
        @Published var activeWalk: Walk? = nil
        @Published var timer: Int = 0
        
        init() {
            activeWalkService.$activeWalk
                .assign(to: &$activeWalk)
            activeWalkService.$timer
                .assign(to: &$timer)
        }
        
        func start() {
            activeWalkService.start()
        }
        
        func stop() {
            activeWalkService.stop()
            saveWalk()
            getAll()
        }
        
        func onAppear() {
            getAll()
        }
        
        private func saveWalk() {
            _ = activeWalkService.activeWalk!.toCoreData(context: viewContext)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
        
        
        private func getAll() {
            let fetchRequest: NSFetchRequest<WalkCoreData> = WalkCoreData.fetchRequest()
            do {
                let result = try viewContext.fetch(fetchRequest)
                walks = result.map {Walk.fromCoreData(coreData: $0)}
            } catch {
                print(error)
            }
        }
    }
}
