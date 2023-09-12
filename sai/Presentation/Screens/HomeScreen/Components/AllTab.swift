//
//  AllTab.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct AllTab: View {
    
    var navigationController: NavigationController
    var homeScreenTripsViewModel: HomeScreenTripsViewModel
    var homeScreenTasksViewModel: HomeScreenTasksViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { geometry in
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        CalendarWidget(parentViewModel: homeScreenTasksViewModel)
                            .frame(width: geometry.size.width * 0.66)
                            .pressable {
                                navigationController.push(to: .calendarScreen)
                            }
                        YourPetWidget()
                    }
                    HStack(spacing: 4) {
                        TripsWidget(parentViewModel: homeScreenTripsViewModel)
                            .frame(width: geometry.size.width * 0.66)
                            .pressable {
                                navigationController.push(to: .walksScreen)
                            }
                        MealPlanWidget()
                    }
                    CheckFeelingWidget()
                }
            }
            
        }
        .padding(.horizontal, 12)
    }
}

struct AllTab_Previews: PreviewProvider {
    static var previews: some View {
        AllTab(navigationController: NavigationController(), homeScreenTripsViewModel: HomeScreenTripsViewModel(homeScreenProvider: HomeScreenProvider()), homeScreenTasksViewModel: HomeScreenTasksViewModel(homeScreenProvider: HomeScreenProvider()))
            .preferredColorScheme(.dark)
    }
}
