//
//  WalkTimer.swift
//  sai
//
//  Created by Николай Попов on 28.08.2023.
//

import SwiftUI

struct WalkTimer: View {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom) {
                Text(hours < 10 ? "0\(hours)" : "\(hours)")
                    .font(Font.custom("Inter", size: 108))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42))
                Typography("h", .semibold(.five))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                  .padding(.bottom, 12)
            }
            HStack(alignment: .bottom) {
                Text(minutes < 10 ? "0\(minutes)" : "\(minutes)")
                    .font(Font.custom("Inter", size: 108))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                Typography("m", .semibold(.five))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                  .padding(.bottom, 12)
            }
            HStack(alignment: .bottom) {
                Text(seconds < 10 ? "0\(seconds)" : "\(seconds)")
                    .font(Font.custom("Inter", size: 108))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Typography("s", .semibold(.five))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.93, green: 0.34, blue: 0.16))
                  .padding(.bottom, 12)
            }
        }
    }
}

struct WalkTimer_Previews: PreviewProvider {
    static var previews: some View {
        WalkTimer(
            hours: 0,
            minutes: 59,
            seconds: 47
        )
        .preferredColorScheme(.dark)
    }
}
