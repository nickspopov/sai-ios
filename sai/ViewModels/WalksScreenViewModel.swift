//
//  WalksScreenViewModel.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import Foundation
import SaiFastAPI
import SwiftUI
import Combine

enum WalksScreenFilter {
     case noFilter, today, week, month, year
    
    static var allCases: [WalksScreenFilter] {
        [.today, .week, .month, .year]
    }
    
    var title: String {
        switch self {
        case .today:
            return "Today"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .year:
            return "Year"
        default:
            return ""
        }
    }
}

enum WalksScreenState {
    case activeWalk
    case today(loading: Bool, stat: GetWalkDayActivity?)
    case week(loading: Bool, stat: GetWalkIntervalActivityByDay?, fromDate: Date, toDate: Date)
    case month(loading: Bool, stat: GetWalkIntervalActivityByDay?, fromDate: Date, toDate: Date)
    case year(loading: Bool)
    
    var filter: WalksScreenFilter {
        switch self {
        case .today:
            return .today
        case .week:
            return .week
        case .month:
            return .month
        case .year:
            return .year
        default:
            return .noFilter
        }
    }
    
    static var initialState: WalksScreenState = .today(loading: false, stat: nil)
}

class WalksScreenViewModel: ObservableObject {
    @Published var state: WalksScreenState = .initialState
    
    @Published var activeWalk: Walk? = nil
    @Published var timer: Int = 0
    
    
    init() {
        activeWalkService.$activeWalk
            .assign(to: &$activeWalk)
        activeWalkService.$timer
            .assign(to: &$timer)
    }
    
    private let activeWalkService = ActiveWalkService.shared
    private var cancelable: AnyCancellable? = nil
    
    func onChangeFilter(to newFilter: WalksScreenFilter) {
        switch newFilter {
        case .today:
            self.state = .today(loading: true, stat: nil)
            getTodayData()
        case .week:
            let fromDate = Date().startOfWeek()
            let toDate = Date().endOfWeek().endOfDay()
            self.state = .week(loading: true, stat: nil, fromDate: fromDate, toDate: toDate)
            getWeekData(fromDate: fromDate, toDate: toDate)
        case .month:
            let fromDate = Date().startOfMonth()
            let toDate = Date().endOfMonth().endOfDay()
            self.state = .month(loading: true, stat: nil, fromDate: fromDate, toDate: toDate)
            getMonthData(fromDate: fromDate, toDate: toDate)
        case .year:
            self.state = .year(loading: true)
        default:
            return
        }
    }
    
    func onAppear() {
        getTodayData()
    }
    
    func startWalk() {
        activeWalkService.start()
        withAnimation(.spring()) {
            self.state = .activeWalk
        }
    }
    
    func stopWalk() {
        activeWalkService.stop()
        withAnimation(.spring()) {
            self.state = .today(loading: true, stat: nil)
        }
        sendLastWalk()
    }
    
    private func sendLastWalk() {
        guard let walk = activeWalk else {
            return
        }
        
        Network.shared.apollo.perform(mutation: CreateWalkMutation(
            input: CreateWalkInput(
                startedAt: walk.startedAt.ISO8601Format(), finishedAt: Date().ISO8601Format(), walkHistory: CreateWalkHistoryType(history: walk.walkHistory.history.map({ _historyItem in
                    CreateWalkHistoryItemType(
                        latitude: _historyItem.latitude,
                        longitude: _historyItem.longitude,
                        timestamp: _historyItem.timestamp.ISO8601Format()
                    )
                }))
            )
        )) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let graphQLResult):
                print(graphQLResult)
                self.getTodayData()
            case .failure(_):
                return
            }
        }
    }
    
    private func getMonthData(fromDate: Date, toDate: Date) {
        Task {
            Network.shared.apollo.fetch(query: GetWalkIntervalActivityByDayQuery(
                fromDate: fromDate.ISO8601Format(),
                toDate: toDate.ISO8601Format()
            ), cachePolicy: .fetchIgnoringCacheData) { [weak self] result in
                guard let self = self else {
                    return
                }

                if self.state.filter != .month {
                    return
                }

                switch result {
                case .success(let graphQLResult):
                    let newState: WalksScreenState = .month(loading: false, stat: graphQLResult.data?.getWalkIntervalActivityByDay.toSwift(), fromDate: fromDate, toDate: toDate)
                    self.state = newState
                case .failure(_):
                    self.state = .month(loading: false, stat: nil, fromDate: fromDate, toDate: toDate)
                }
            }
        }
    }
    
    private func getWeekData(fromDate: Date, toDate: Date) {
        Task {
            Network.shared.apollo.fetch(query: GetWalkIntervalActivityByDayQuery(
                fromDate: fromDate.ISO8601Format(),
                toDate: toDate.ISO8601Format()
            ), cachePolicy: .fetchIgnoringCacheData) { [weak self] result in
                guard let self = self else {
                    return
                }

                if self.state.filter != .week {
                    return
                }

                switch result {
                case .success(let graphQLResult):
                    let newState: WalksScreenState = .week(loading: false, stat: graphQLResult.data?.getWalkIntervalActivityByDay.toSwift() ,fromDate: fromDate, toDate: toDate)
                    self.state = newState
                case .failure(_):
                    self.state = .week(loading: false, stat: nil, fromDate: fromDate, toDate: toDate)
                }
            }
        }
    }
    
    private func getTodayData() {
        Task {
            let date = Date().startOfDay().ISO8601Format()
            Network.shared.apollo.fetch(query: GetWalkDayActivityQuery(
                date: date
            ), cachePolicy: .fetchIgnoringCacheData) { [weak self] result in
                guard let self = self else {
                    return
                }
                
                if self.state.filter != .today {
                    return
                }
                
                switch result {
                case .success(let graphQLResult):
                    self.state = .today(loading: false, stat: graphQLResult.data?.getWalkDayActivity.toSwiftModel())
                case .failure(_):
                    self.state = .today(loading: false, stat: nil)
                }
            }
        }
    }
}
