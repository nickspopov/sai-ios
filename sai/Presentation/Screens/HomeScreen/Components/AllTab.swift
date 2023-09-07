//
//  AllTab.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct AllTab: View {
    
    var navigationController: NavigationController
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { geometry in
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        CalendarWidget()
                            .frame(width: geometry.size.width * 0.66)
                            .pressable {
                                navigationController.push(to: .calendarScreen)
                            }
                        YourPetWidget()
                    }
                    HStack(spacing: 4) {
                        TripsWidget()
                            .frame(width: geometry.size.width * 0.66)
                            .pressable {
                                navigationController.push(to: .walksScreen)
                            }
                        MealPlanWidget()
                    }
                }
            }
            
        }
        .padding(.horizontal, 16)
    }
}

struct AllTab_Previews: PreviewProvider {
    static var previews: some View {
        AllTab(navigationController: NavigationController())
            .preferredColorScheme(.dark)
    }
}
