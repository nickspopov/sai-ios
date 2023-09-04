//
//  WalksScreen.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import SwiftUI
import SaiFastAPI
import Charts

struct WalksScreen: View {
    @EnvironmentObject var navigationController: NavigationController
    
    @StateObject var viewModel = WalksScreenViewModel()
    
    @Namespace var namespace
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                if (viewModel.state.filter != .noFilter) {
                    filtersRow
                }
                switch viewModel.state {
                case .today(let loading, let stat):
                    todayLayout(loading, stat)
                case .activeWalk:
                    activeWalkLayout()
                case .week(let loading, let stat, let fromDate, let toDate):
                    chartByDayLayout(loading, stat, fromDate: fromDate, toDate: toDate)
                case .month(let loading, let stat, let fromDate, let toDate):
                    chartByDayLayout(loading, stat, fromDate: fromDate, toDate: toDate)
                default:
                    Text("Not implemented")
                }
                Spacer()
            }
            .onAppear(perform: viewModel.onAppear)
            .screenContainer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct WalksScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        WalksScreen()
            .preferredColorScheme(.dark)
    }
}

extension WalksScreen {
    func chartByDayLayout(_ loading: Bool, _ stat: GetWalkIntervalActivityByDay?, fromDate: Date, toDate: Date) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                Typography(String(format: "%.2f", (stat?.totalDuration ?? 0.0) / 60 / 60), .semibold(.one))
                Typography("hr", .semibold(.six))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
                    .padding(.top)
                Spacer()
            }
            .padding(.bottom, 2)
            Typography("\(fromDate.format(format: "MMM dd")) - \(toDate.format(format: "MMM dd, YYYY"))", .semibold(.six))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
            Spacer()
                .frame(height: 57)
            VStack {
                Chart {
                    ForEach(stat?.items ?? [], id: \.self) { _item in
                        BarMark(x: .value("Day", _item.date.format(format: "d")), y: .value("Value", _item.duration))
                            .foregroundStyle(Color.accentOrange)
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisValueLabel {
                            if(value.count < 10) {
                                Text(value.as(String.self) ?? "")
                            } else {
                                if (value.index % 2 == 0) {
                                    Text(value.as(String.self) ?? "")
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 187, maxHeight: 187)
            Spacer()
                .frame(height: 40)
            HStack {
                Typography("Distance", .semibold(.six))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
                Spacer()
                Typography("\(String(format:"%.1f", stat?.totalDistance ?? 0.0))km", .semibold(.six))
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .background(Color(red: 0.13, green: 0.13, blue: 0.13))
            .cornerRadius(16)
        }
        .padding(.horizontal, 20)
    }
}

extension WalksScreen {
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


extension WalksScreen {
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
        .padding(.horizontal, 20)
    }
}

extension WalksScreen {
    var filtersRow: some View {
        HStack(alignment: .center, spacing: 20) {
            ForEach(WalksScreenFilter.allCases, id: \.self) { _filter in
                Button(action: {viewModel.onChangeFilter(to: _filter)}, label: {
                    Text("\(_filter.title)")
                        .foregroundColor(viewModel.state.filter == _filter ? .white : .white.opacity(0.42))
                })
                .buttonStyle(TextButton(.medium))

            }
            Spacer()
        }
        .padding(.bottom, 44)
        .padding(.horizontal, 24)
    }
}

extension WalksScreen {
    var header: some View {
        HStack {
            Button(action: { navigationController.pop() }) {
                Typography("Back")
            }.buttonStyle(PrimaryButton(.small))
            Spacer()
            Typography("Activity", .semibold(.six))
            Spacer()
            Button(action: {}) {
                Typography("Back")
            }.buttonStyle(PrimaryButton(.small))
                .opacity(0)
        }
        .padding(.top, 32)
        .padding(.bottom, 40)
        .padding(.horizontal, 20)
    }
}
