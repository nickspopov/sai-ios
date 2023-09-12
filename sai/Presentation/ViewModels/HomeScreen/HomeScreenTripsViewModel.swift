//
//  HomeScreenTripsViewModel.swift
//  sai
//
//  Created by Николай Попов on 11.09.2023.
//

import Foundation
import SwiftUI
import Combine

class HomeScreenTripsViewModel: ObservableObject {
    var homeScreenProvider: HomeScreenProvider
    
    @Published var activeWalk: Walk? = nil
    @Published var timer: Int = 0
    @Published var running: Bool = false
    @Published var statistic: GetWalkDayActivity? = nil
    
    private let walksRepository = WalksRepositoryImpl.shared
    private let activeWalkService = ActiveWalkService.shared
    
    private var subscribers: Set<AnyCancellable> = []
    private var date: Date = Date()
    
    init(homeScreenProvider: HomeScreenProvider) {
        self.homeScreenProvider = homeScreenProvider
        homeScreenProvider.$selectedDate.sink { selectedDate in
            self.date = selectedDate
            self.updateStatistic()
        }.store(in: &subscribers)
        
        activeWalkService.$activeWalk
            .assign(to: &$activeWalk)
        activeWalkService.$timer
            .assign(to: &$timer)
        activeWalkService.$isRunning
            .assign(to: &$running)
        
//        activeWalkService.$isRunning.sink{ _isRunning in
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.running = _isRunning
//                }
//            }
//        }.store(in: &subscribers)
    }
    
    func updateStatistic() {
        getCachedStatistic()
        getNetworkStatistic()
    }
    
    
    private func getCachedStatistic() {
        Task {
            let date = date.startOfDay()
            let cached = await walksRepository.getOneDayAnalyticCached(for: date)
            DispatchQueue.main.async {
                self.statistic = cached
            }
        }
    }
    
    private func getNetworkStatistic() {
        Task {
            let date = date.startOfDay()
            do {
                let result = try await walksRepository.getOneDayAnalytic(for: date)
                
                DispatchQueue.main.async {
                    self.statistic = result
                }
            } catch {}
            
        }
    }
}
