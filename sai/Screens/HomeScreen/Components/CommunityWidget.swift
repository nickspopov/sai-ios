//
//  CommunityWidget.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI

struct CommunityWidget: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Typography("Community name", .semibold(.six))
            Spacer()
                .frame(height: 6)
            Typography("Community", .regular(.eight))
                .foregroundColor(randomGrayColor)
        }
        .padding(.horizontal, 10)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .frame(
            maxWidth: .infinity,
            minHeight: 180,
            maxHeight: 180,
            alignment: .leading
        )
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(12)
    }
}

struct CommunityWidget_Previews: PreviewProvider {
    static var previews: some View {
        CommunityWidget()
            .preferredColorScheme(.dark)
    }
}
