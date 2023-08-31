//
//  WalksScreenViewModel.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import Foundation
import Apollo
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
    
    let walksRepository = WalksRepository.shared
    
    
    init() {
        activeWalkService.$activeWalk
            .assign(to: &$activeWalk)
        activeWalkService.$timer
            .assign(to: &$timer)
    }
    
    private let activeWalkService = ActiveWalkService.shared
    
    func onChangeFilter(to newFilter: WalksScreenFilter) {
        switch newFilter {
        case .today:
            withAnimation {
                self.state = .today(loading: true, stat: lastTodayStat)
            }
            getTodayData()
        case .week:
            let fromDate = Date().startOfWeek()
            let toDate = Date().endOfWeek().endOfDay()
            withAnimation {
                self.state = .week(loading: true, stat: lastWeekStat, fromDate: fromDate, toDate: toDate)
            }
            getWeekData(fromDate: fromDate, toDate: toDate)
        case .month:
            let fromDate = Date().startOfMonth()
            let toDate = Date().endOfMonth().endOfDay() + 1
            withAnimation {
                self.state = .month(loading: true, stat: lastMonthStat, fromDate: fromDate, toDate: toDate)
            }
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
            self.state = .today(loading: true, stat: lastTodayStat)
        }
        if let walk = activeWalk {
            increaseTodayStat(with: walk)
        }
        sendLastWalk()
    }
    
    private func increaseTodayStat(with walk: Walk) {
        guard case .today(let loading, var stat) = state else {
            return
        }
        
        stat?.totalDuration += walk.duration
        stat?.totalDistance += walk.distance
        self.state = .today(loading: loading, stat: stat)
    }
    
    
    private func sendLastWalk() {
        guard let walk = activeWalk else {
            return
        }
        
        Task {
            do {
                _ = try await walksRepository.save(walk)
                getTodayData()
            } catch {
                print(error)
            }
        }
    }
    
    var lastMonthStat: GetWalkIntervalActivityByDay? = nil
    var lastWeekStat: GetWalkIntervalActivityByDay? = nil
    var lastTodayStat: GetWalkDayActivity? = nil
    
    private func getMonthData(fromDate: Date, toDate: Date) {
        Task {
            let cached = await walksRepository.getIntervalAnalyticByDayCached(fromDate: fromDate, toDate: toDate)
            let newState: WalksScreenState = .month(loading: false, stat: cached, fromDate: fromDate, toDate: toDate)
            DispatchQueue.main.async {
                if (self.state.filter != .month) {
                    return
                }
                self.state = newState
            }
            do {
                let result = try await walksRepository.getIntervalAnalyticByDay(fromDate: fromDate, toDate: toDate)
                
                self.lastMonthStat = result
                let newState: WalksScreenState = .month(loading: false, stat: result, fromDate: fromDate, toDate: toDate)
                
                DispatchQueue.main.async {
                    if (self.state.filter != .month) {
                        return
                    }
                    self.state = newState
                }
            } catch {}
        }
    }
    
    private func getWeekData(fromDate: Date, toDate: Date) {
        Task {
            let cached = await walksRepository.getIntervalAnalyticByDayCached(fromDate: fromDate, toDate: toDate)
            let newState: WalksScreenState = .week(loading: false, stat: cached, fromDate: fromDate, toDate: toDate)
            DispatchQueue.main.async {
                if (self.state.filter != .week) {
                    return
                }
                self.state = newState
            }
            do {
                let result = try await walksRepository.getIntervalAnalyticByDay(fromDate: fromDate, toDate: toDate)
                
                self.lastWeekStat = result
                
                let newState: WalksScreenState = .week(loading: false, stat: result, fromDate: fromDate, toDate: toDate)
                DispatchQueue.main.async {
                    if (self.state.filter != .week) {
                        return
                    }
                    self.state = newState
                }
            } catch {}
        }
    }
    
    private func getTodayData() {
        Task {
            let date = Date().startOfDay()
            let cached = await walksRepository.getOneDayAnalyticCached(for: date)
            let newState: WalksScreenState = .today(loading: false, stat: cached)
            DispatchQueue.main.async {
                if (self.state.filter != .today) {
                    return
                }
                self.state = newState
            }
            do {
                let result = try await walksRepository.getOneDayAnalytic(for: date)
                
                self.lastTodayStat = result
                
                let newState: WalksScreenState = .today(loading: false, stat: result)
                DispatchQueue.main.async {
                    if (self.state.filter != .today) {
                        return
                    }
                    self.state = newState
                }
            } catch {}
            
        }
    }
}
