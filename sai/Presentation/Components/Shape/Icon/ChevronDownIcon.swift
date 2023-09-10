//
//  ChevronDownIcon.swift
//  sai
//
//  Created by Николай Попов on 10.09.2023.
//

import SwiftUI

struct ChevronDownIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.5*width, y: 0.64581*height))
        path.addCurve(to: CGPoint(x: 0.47194*width, y: 0.6336*height), control1: CGPoint(x: 0.48983*width, y: 0.64581*height), control2: CGPoint(x: 0.47968*width, y: 0.64173*height))
        path.addLine(to: CGPoint(x: 0.31321*width, y: 0.46694*height))
        path.addCurve(to: CGPoint(x: 0.31321*width, y: 0.40802*height), control1: CGPoint(x: 0.29769*width, y: 0.45064*height), control2: CGPoint(x: 0.29769*width, y: 0.42431*height))
        path.addCurve(to: CGPoint(x: 0.36932*width, y: 0.40802*height), control1: CGPoint(x: 0.32872*width, y: 0.39173*height), control2: CGPoint(x: 0.3538*width, y: 0.39173*height))
        path.addLine(to: CGPoint(x: 0.50047*width, y: 0.54573*height))
        path.addLine(to: CGPoint(x: 0.63114*width, y: 0.41323*height))
        path.addCurve(to: CGPoint(x: 0.68726*width, y: 0.41427*height), control1: CGPoint(x: 0.64698*width, y: 0.39727*height), control2: CGPoint(x: 0.67202*width, y: 0.39773*height))
        path.addCurve(to: CGPoint(x: 0.6863*width, y: 0.47319*height), control1: CGPoint(x: 0.7025*width, y: 0.43081*height), control2: CGPoint(x: 0.70206*width, y: 0.45723*height))
        path.addLine(to: CGPoint(x: 0.52757*width, y: 0.63411*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.64581*height), control1: CGPoint(x: 0.51983*width, y: 0.64193*height), control2: CGPoint(x: 0.50991*width, y: 0.64581*height))
        path.closeSubpath()
        return path
    }
}

struct ChevronDownIcon_Previews: PreviewProvider {
    static var previews: some View {
        ChevronDownIcon()
            .frame(width: 100, height: 100)
    }
}
