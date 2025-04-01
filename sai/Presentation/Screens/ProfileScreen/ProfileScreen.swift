//
//  ProfileScreen.swift
//  sai
//
//  Created by Nick Popov on 01.04.2025.
//

import SwiftUI

struct ProfileScreen: View {

    @StateObject var viewModel = ProfileScreenViewModel()

    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text(user.id)
                Text(user.name)
            } else {
                Text("Loading...")
            }
            Spacer()
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button("Save") {
                    viewModel.onSave()
                }
                .buttonStyle(PrimaryButton(.large, color: .accentOrange))
            }
            Button("Log out") {
                AuthServiceFirebaseImpl.shared.signOut()
            }
            .buttonStyle(SecondaryButton(.large, color: .accentOrange))
        }
        .onAppear {
            viewModel.onAppear()
        }
        .padding()
    }
}

#Preview {
    ProfileScreen()
}
