//
//  TripsWidget.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI

struct TripsWidget: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            mapView
            overlay
            info
        }.frame(
            maxWidth: .infinity,
            minHeight: 180,
            maxHeight: 180
        )
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(8)
        .onAppear(perform: viewModel.onAppear)
    }
}

// MARK: - Map
extension TripsWidget {
    var mapView: some View {
        let locationHistory = viewModel.walk?.walkHistory.toCLLocationCoordinate2DArray() ?? []
        return MapView(locationHistory: locationHistory)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .cornerRadius(8)
    }
}

// MARK: - Overlay
extension TripsWidget {
    var overlay: some View {
        VStack{}
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .black.opacity(0.9), location: 0.0),
                        Gradient.Stop(color: .black.opacity(0.6), location: 0.6),
                        Gradient.Stop(color: .black.opacity(0.3), location: 1),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)
                )
            )
    }
}

// MARK: - Info
extension TripsWidget {
    var info: some View {
        guard let walk = viewModel.walk else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    Typography("\(String(format: "%.2f", walk.distance)) km", .semibold(.six))
                    Typography("Distance", .regular(.eight))
                        .foregroundColor(Color(red: 0.64, green: 0.67, blue: 0.69))
                    
                }
                VStack(alignment: .leading, spacing: 0) {
                    Typography(walk.duration.stringFromTimeInterval(), .semibold(.six))
                    Typography("Duration", .regular(.eight))
                        .foregroundColor(Color(red: 0.64, green: 0.67, blue: 0.69))
                    
                }
            }.padding(10)
        )
    }
}



// MARK: - ViewModel
extension TripsWidget {
    class ViewModel: ObservableObject {
        let walksRepository = WalksRepositoryImpl.shared
        
        @Published var walk: Walk? = nil
        
        func onAppear() {
            Task {
                do {
                    let _walk = try await walksRepository.get(by: "64ef8bb1e983cfe11cb53fe0")
                    DispatchQueue.main.async {
                        self.walk = _walk
                    }

//                    if let _walk = try await walksRepository.getLast() {
//                        DispatchQueue.main.async {
//                            self.walk = _walk
//                        }
//                    }
                } catch {
                    print(error)
                }
            }
        }
        
    }
}


// MARK: - Preview
struct TripsWidget_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            TripsWidget()
            TripsWidget()
        }
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
    }
}
