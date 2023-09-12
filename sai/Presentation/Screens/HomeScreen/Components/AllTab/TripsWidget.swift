//
//  TripsWidget.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI
import Combine
import SaiFastAPI

struct TripsWidget: View {
    
    var parentViewModel: HomeScreenTripsViewModel
    @StateObject private var viewModel: ViewModel
    
    
    init(parentViewModel: HomeScreenTripsViewModel) {
        self._viewModel = StateObject(wrappedValue: ViewModel(parentViewModel: parentViewModel))
        self.parentViewModel = parentViewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Typography("Distance", .medium(.six))
                .frame(height: 24)
            Spacer()
            HStack(alignment: .bottom) {
                Typography(String(format: "%.2f", viewModel.statistic?.totalDistance ?? 0), .medium(.one))
                Typography("km", .medium(.four))
                    .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                    .offset(y: -4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(
            maxWidth: .infinity,
            minHeight: 98,
            maxHeight: 98,
            alignment: .leading
        )
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(24)
    }
}

// MARK: - ViewModel
extension TripsWidget {
    class ViewModel: ObservableObject {
        var parentViewModel: HomeScreenTripsViewModel
        
        let walksRepository = WalksRepositoryImpl.shared
        
        @Published var statistic: GetWalkDayActivity? = nil
        
        private var subscribers: Set<AnyCancellable> = []
        private var date: Date = Date()
        
        init(parentViewModel: HomeScreenTripsViewModel) {
            self.parentViewModel = parentViewModel
            parentViewModel.$statistic.sink { newStat in
                self.statistic = newStat
            }
            .store(in: &subscribers)
        }
//
//        func onAppear() {
//            Task {
//                do {
//                    let _statistic = try await walksRepository.getOneDayAnalytic(for: self.date.startOfDay())
//                        DispatchQueue.main.async {
//                            self.statistic = _statistic
//                        }
//                } catch {
//                    print(error)
//                }
//            }
//        }
        
    }
}


// MARK: - Preview
struct TripsWidget_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            TripsWidget(parentViewModel: HomeScreenTripsViewModel(homeScreenProvider: HomeScreenProvider()))
            TripsWidget(parentViewModel: HomeScreenTripsViewModel(homeScreenProvider: HomeScreenProvider()))
        }
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
    }
}
