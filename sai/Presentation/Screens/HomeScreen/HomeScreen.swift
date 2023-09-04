//
//  HomeScreen.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var navigationController: NavigationController
    
    
    var body: some View {
        NavigationView {
            VStack{
                Group {
                    header
                    Spacer()
                        .frame(height: 40)
                }
                VStack(spacing: 10) {
                    CalendarWidget()
                        .pressable {
                            navigationController.push(to: .calendarScreen)
                        }
                    HStack(spacing: 10) {
                        TripsWidget()
                            .pressable {
                                navigationController.push(to: .walksScreen)
                            }
                        CommunityWidget()
                    }
                    Spacer()
                    Button(action: AuthServiceFirebaseImpl.shared.signOut) {
                        Text("Logout")
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 36)
            .screenContainer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


// MARK: - Header
extension HomeScreen {
    var header: some View {
        HStack {
            Circle()
                .frame(width: 58, height: 58)
                .foregroundColor(Color(red: 55, green: 55, blue: 55))
            Spacer()
                .frame(width: 20)
            VStack(alignment: .leading) {
                Typography("Hello, Nick", .semibold(.two))
                Typography("How Sai feels today?", .regular(.seven))
                    .foregroundColor(Color(uiColor: UIColor(red: 0.64, green: 0.67, blue: 0.69, alpha: 1)))
            }
            Spacer()
        }
        .padding(.horizontal, 4)
    }
}
