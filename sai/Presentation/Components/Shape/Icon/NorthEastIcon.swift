//
//  NorthEastIcon.swift
//  sai
//
//  Created by Николай Попов on 10.09.2023.
//

import SwiftUI

struct NorthEastIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.37499*width, y: 0.25*height))
        path.addCurve(to: CGPoint(x: 0.41666*width, y: 0.29167*height), control1: CGPoint(x: 0.37499*width, y: 0.27333*height), control2: CGPoint(x: 0.39374*width, y: 0.29167*height))
        path.addLine(to: CGPoint(x: 0.64957*width, y: 0.29167*height))
        path.addLine(to: CGPoint(x: 0.19582*width, y: 0.74542*height))
        path.addCurve(to: CGPoint(x: 0.19582*width, y: 0.80417*height), control1: CGPoint(x: 0.17957*width, y: 0.76167*height), control2: CGPoint(x: 0.17957*width, y: 0.78792*height))
        path.addCurve(to: CGPoint(x: 0.25457*width, y: 0.80417*height), control1: CGPoint(x: 0.21207*width, y: 0.82042*height), control2: CGPoint(x: 0.23832*width, y: 0.82042*height))
        path.addLine(to: CGPoint(x: 0.70832*width, y: 0.35042*height))
        path.addLine(to: CGPoint(x: 0.70832*width, y: 0.58333*height))
        path.addCurve(to: CGPoint(x: 0.74999*width, y: 0.625*height), control1: CGPoint(x: 0.70832*width, y: 0.60625*height), control2: CGPoint(x: 0.72707*width, y: 0.625*height))
        path.addCurve(to: CGPoint(x: 0.79165*width, y: 0.58333*height), control1: CGPoint(x: 0.7729*width, y: 0.625*height), control2: CGPoint(x: 0.79165*width, y: 0.60625*height))
        path.addLine(to: CGPoint(x: 0.79165*width, y: 0.25*height))
        path.addCurve(to: CGPoint(x: 0.74999*width, y: 0.20833*height), control1: CGPoint(x: 0.79165*width, y: 0.22708*height), control2: CGPoint(x: 0.7729*width, y: 0.20833*height))
        path.addLine(to: CGPoint(x: 0.41666*width, y: 0.20833*height))
        path.addCurve(to: CGPoint(x: 0.37499*width, y: 0.25*height), control1: CGPoint(x: 0.39374*width, y: 0.20833*height), control2: CGPoint(x: 0.37499*width, y: 0.22708*height))
        path.closeSubpath()
        return path
    }
}

struct NorthEastIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NorthEastIcon()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            NorthEastIcon()
                .stroke()
                .frame(width: 100, height: 100)
        }
    }
}
