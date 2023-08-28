//
//  WalksScreen.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import SwiftUI

struct WalksScreen: View {
    @EnvironmentObject var navigationController: NavigationController
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                Spacer()
            }
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
    }
}
