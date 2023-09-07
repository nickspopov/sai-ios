//
//  YourPetWidget.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct YourPetWidget: View {
    var body: some View {
        VStack {
            Typography("Your pet", .medium(.five))
                .foregroundColor(.black)
                .frame(height: 26)
            Spacer()
            Circle()
                .foregroundColor(.gray)
                .frame(width: 84, height: 84)
        }
        .padding(.top, 10)
        .padding(.bottom, 18)
        .frame(maxWidth: .infinity, minHeight: 164, maxHeight: 164)
        .background(
            ZStack {
                Color.white
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                    .padding(.top, 44)
            }
            .cornerRadius(24)
        )
    }
}

struct YourPetWidget_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            YourPetWidget()
                .preferredColorScheme(.dark)
        }.frame(width: 118)
    }
}
