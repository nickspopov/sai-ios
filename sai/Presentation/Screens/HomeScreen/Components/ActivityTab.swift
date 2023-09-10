//
//  ActivityTab.swift
//  sai
//
//  Created by Николай Попов on 07.09.2023.
//

import SwiftUI
import Combine

struct ActivityTab: View {
    
    var homeScreenViewModel: HomeScreenViewModel
    @StateObject private var viewModel: ViewModel
    
    init(homeScreenViewModel: HomeScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: ViewModel(parentViewModel: homeScreenViewModel))
        self.homeScreenViewModel = homeScreenViewModel
    }
    
    @Namespace var namespace
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{}.frame(maxWidth: .infinity)
            if viewModel.running {
                activeWalkLayout()
            } else {
                todayLayout(false, viewModel.statistic)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ActivityTab_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTab(homeScreenViewModel: HomeScreenViewModel())
            .preferredColorScheme(.dark)
    }
}

// MARK - Active walk layout
extension ActivityTab {
    func activeWalkLayout() -> some View {
        let timer = viewModel.timer
        return VStack {
            WalkTimer(hours: Int(timer / 60 / 60), minutes: Int(timer / 60), seconds:         Int(Double(timer)
                .truncatingRemainder(dividingBy: 60)))
            .matchedGeometryEffect(id: "timer", in: namespace)
            Spacer()
                .frame(height: 80)
            Text("Distance: \(viewModel.activeWalk?.distance ?? 0, specifier: "%.2f")km")
                .font(Font.custom("Inter", size: 24))
                .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
            Button(action: {viewModel.stopWalk()}) {
                Text("Stop")
            }
            .buttonStyle(SecondaryButton(.medium, color: .accentOrange))
            .padding(.top, 24)
            .matchedGeometryEffect(id: "startButton", in: namespace)
        }
        .padding(.horizontal, 20)
    }
}


// MARK: - Today layout
extension ActivityTab {
    func todayLayout(_ loading: Bool, _ stat: GetWalkDayActivity?) -> some View {
        VStack {
            HStack(alignment: .top, spacing: 60) {
                WalkTimer(hours: stat?.hours ?? 0, minutes: stat?.minutes ?? 0, seconds: stat?.seconds ?? 0)
                    .matchedGeometryEffect(id: "timer", in: namespace)
                VStack(alignment: .leading, spacing: 50) {
                    VStack(alignment: .leading) {
                        Typography("Distance", .semibold(.seven))
                            .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                        Text("\(stat?.totalDistance ?? 0, specifier: "%.2f")km")
                            .font(Font.custom("Inter", size: 32))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading) {
                        Typography("Avg. Speed", .semibold(.seven))
                            .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                        Text("\(stat?.avgSpeed ?? 0, specifier: "%.0f")km/h")
                            .font(Font.custom("Inter", size: 32))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading) {
                        Typography("Avg. Pace", .semibold(.seven))
                            .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                        Text("\(stat?.avgPace ?? 0, specifier: "%.0f")h/km")
                            .font(Font.custom("Inter", size: 32))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 80)
            }
            Button(action: {viewModel.startWalk()}) {
                Text("Start")
            }
            .buttonStyle(PrimaryButton(.large, color: .accentOrange))
            .padding(.top, 24)
            .matchedGeometryEffect(id: "startButton", in: namespace)
        }
        .onAppear(perform: viewModel.getStatistic)
        .padding(.horizontal, 20)
    }
}

extension ActivityTab {
    class ViewModel: ObservableObject {
        var parentViewModel: HomeScreenViewModel
        
        @Published var activeWalk: Walk? = nil
        @Published var timer: Int = 0
        @Published var running: Bool = false
        @Published var statistic: GetWalkDayActivity? = nil
        
        private let walksRepository = WalksRepositoryImpl.shared
        private let activeWalkService = ActiveWalkService.shared
        
        private var subscribers: Set<AnyCancellable> = []
        private var date: Date = Date()
        
        init(parentViewModel: HomeScreenViewModel) {
            self.parentViewModel = parentViewModel
            parentViewModel.$selectedDate.sink { selectedDate in
                self.date = selectedDate
                self.getStatistic()
            }.store(in: &subscribers)
            
            activeWalkService.$activeWalk
                .assign(to: &$activeWalk)
            activeWalkService.$timer
                .assign(to: &$timer)
            
            activeWalkService.$isRunning.sink{ _isRunning in
                DispatchQueue.main.async {
                    withAnimation {
                        self.running = _isRunning
                    }
                }
            }.store(in: &subscribers)
        }
        
        
        func startWalk() {
            activeWalkService.start()
            withAnimation(.spring()) {
                self.running = true
            }
        }
        
        func stopWalk() {
            activeWalkService.stop()
            withAnimation(.spring()) {
                self.running = false
            }
            sendLastWalk()
        }
        
        func getStatistic() {
            Task {
                let date = date.startOfDay()
                let cached = await walksRepository.getOneDayAnalyticCached(for: date)
                DispatchQueue.main.async {
                    self.statistic = cached
                }
                do {
                    let result = try await walksRepository.getOneDayAnalytic(for: date)
                    
                    DispatchQueue.main.async {
                        self.statistic = result
                    }
                } catch {}
                
            }
        }
        
        private func sendLastWalk() {
            guard let walk = activeWalk else {
                return
            }
            Task {
                do {
                    _ = try await walksRepository.save(walk)
                    getStatistic()
                } catch {
                    print(error)
                }
            }
        }
    }
}
