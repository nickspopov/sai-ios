//
//  ActivityTab.swift
//  sai
//
//  Created by Николай Попов on 07.09.2023.
//

import SwiftUI
import Combine

struct ActivityTab: View {
    @StateObject var viewModel = ViewModel()
    
//    @Namespace var namespace
    
    
    var body: some View {
        let timer = viewModel.timer
        
        ScrollView(showsIndicators: false) {
            WalkTimer(hours: Int(timer / 60 / 60), minutes: Int(timer / 60), seconds: Int(Double(timer)
                .truncatingRemainder(dividingBy: 60)))
//                .matchedGeometryEffect(id: "timer", in: namespace)
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
//            .matchedGeometryEffect(id: "startButton", in: namespace)
        }
//        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ActivityTab_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTab()
            .preferredColorScheme(.dark)
    }
}


extension ActivityTab {
    class ViewModel: ObservableObject {
        @Published var activeWalk: Walk? = nil
        @Published var timer: Int = 0
        
        private let walksRepository = WalksRepositoryImpl.shared
        private let activeWalkService = ActiveWalkService.shared
        
        init() {
            activeWalkService.$activeWalk
                .assign(to: &$activeWalk)
            activeWalkService.$timer
                .assign(to: &$timer)
        }
        
        
        func startWalk() {}
        
        func stopWalk() {}
    }
}
