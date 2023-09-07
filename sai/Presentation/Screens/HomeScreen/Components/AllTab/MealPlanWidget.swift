//
//  MealPlanWidget.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct MealPlanWidget: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 6) {
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.green)
                Typography("Meal plan", .medium(.seven))
                    .frame(height: 24)
            }
            Typography("from:\nAug, 6 2023", .regular(.seven))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(
            maxWidth: .infinity,
            minHeight: 98,
            maxHeight: 98
        )
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(24)
    }
}

struct MealPlanWidget_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MealPlanWidget()
                .preferredColorScheme(.dark)
        }.frame(width: 118)
    }
}
