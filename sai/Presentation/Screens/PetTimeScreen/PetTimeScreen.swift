//
//  PetTimeScreen.swift
//  sai
//
//  Created by Николай Попов on 20.09.2023.
//

import SwiftUI

struct PetTimeScreen: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            content
        }
        .onAppear { viewModel.onApear() }
    }
}

#Preview {
    PetTimeScreen()
}


// MARK: - Loaded UI
extension PetTimeScreen {
    @ViewBuilder var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded(let petTimes):
            List {
                ForEach(petTimes, id: \.id) { petTime in
                    Text(petTime.name)
                }
            }
        case .error(let error):
            Text(error.localizedDescription)
        }
    }
}

// MARK: - ViewModel
extension PetTimeScreen {
    class ViewModel: ObservableObject {
        @Published var state: State = .loading
        
        private let communityRepository = CommunityRepositoryImpl.shared
        
        func onApear() {
            Task {
                await load()
            }
        }
        
        private func load() async {
            do {
                let petTimes = try await communityRepository.getAll()
                DispatchQueue.main.async {
                    self.state = .loaded(petTimes)
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .error(error)
                }
            }
        }
        
        enum State {
            case loading
            case loaded([CommunityModel])
            case error(Error)
        }
    }
}
