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
        VStack(alignment: .leading) {
            Typography("Distance", .medium(.six))
                .frame(height: 24)
            Spacer()
            HStack(alignment: .bottom) {
                Typography(String(format: "%.2f", viewModel.walk?.distance ?? 0), .medium(.one))
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
        .onAppear(perform: viewModel.onAppear)
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
                    if let _walk = try await walksRepository.getLast() {
                        DispatchQueue.main.async {
                            self.walk = _walk
                        }
                    }
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
