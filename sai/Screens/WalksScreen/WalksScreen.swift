//
//  WalksScreen.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import SwiftUI

struct WalksScreen: View {
    @EnvironmentObject var navigationController: NavigationController
    
    @StateObject var viewModel = WalksScreenViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                today()
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
    }
}


extension WalksScreen {
    var header: some View {
        HStack {
            Button(action: { navigationController.pop() }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
    }
}


extension WalksScreen {
    func today() -> some View {
        guard viewModel.stat != nil else { return AnyView(ProgressView().progressViewStyle(.circular)) }
        
        return AnyView(
            VStack {
                if viewModel.stat != nil {
                    Text("duration: \(viewModel.stat?.totalDuration ?? 0)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.72))
                    Text("avg speed: \(viewModel.stat?.avgSpeed ?? 0)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.72))
                    Text("distance: \(viewModel.stat?.totalDistance ?? 0)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.72))
                }
            })
    }
}
