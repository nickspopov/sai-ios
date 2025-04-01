//
//  TripBackgroundShape.swift
//  sai
//
//  Created by Николай Попов on 10.09.2023.
//

import SwiftUI

struct TripBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: -0.07444*width, y: 0.03978*height))
        path.addLine(to: CGPoint(x: -0.09603*width, y: 0.06632*height))
        path.addCurve(to: CGPoint(x: -0.11538*width, y: 0.11912*height), control1: CGPoint(x: -0.10863*width, y: 0.08181*height), control2: CGPoint(x: -0.11538*width, y: 0.10023*height))
        path.addLine(to: CGPoint(x: -0.11538*width, y: 1.06593*height))
        path.addLine(to: CGPoint(x: 1.11538*width, y: 1.06593*height))
        path.addLine(to: CGPoint(x: 1.11538*width, y: 0.12855*height))
        path.addCurve(to: CGPoint(x: 1.00729*width, y: 0.08811*height), control1: CGPoint(x: 1.11538*width, y: 0.08041*height), control2: CGPoint(x: 1.04847*width, y: 0.05538*height))
        path.addCurve(to: CGPoint(x: 0.93434*width, y: 0.09681*height), control1: CGPoint(x: 0.98751*width, y: 0.10383*height), control2: CGPoint(x: 0.95838*width, y: 0.10731*height))
        path.addLine(to: CGPoint(x: 0.91545*width, y: 0.08856*height))
        path.addCurve(to: CGPoint(x: 0.79236*width, y: 0.11758*height), control1: CGPoint(x: 0.87184*width, y: 0.06952*height), control2: CGPoint(x: 0.81847*width, y: 0.0821*height))
        path.addLine(to: CGPoint(x: 0.74748*width, y: 0.17854*height))
        path.addCurve(to: CGPoint(x: 0.62264*width, y: 0.21694*height), control1: CGPoint(x: 0.72109*width, y: 0.2144*height), control2: CGPoint(x: 0.6696*width, y: 0.23023*height))
        path.addLine(to: CGPoint(x: 0.60019*width, y: 0.21059*height))
        path.addCurve(to: CGPoint(x: 0.5462*width, y: 0.17644*height), control1: CGPoint(x: 0.57841*width, y: 0.20442*height), control2: CGPoint(x: 0.5595*width, y: 0.19246*height))
        path.addLine(to: CGPoint(x: 0.47217*width, y: 0.08724*height))
        path.addCurve(to: CGPoint(x: 0.36105*width, y: 0.05064*height), control1: CGPoint(x: 0.44708*width, y: 0.05701*height), control2: CGPoint(x: 0.40331*width, y: 0.04259*height))
        path.addLine(to: CGPoint(x: 0.3032*width, y: 0.06166*height))
        path.addCurve(to: CGPoint(x: 0.28214*width, y: 0.06768*height), control1: CGPoint(x: 0.29596*width, y: 0.06304*height), control2: CGPoint(x: 0.2889*width, y: 0.06506*height))
        path.addLine(to: CGPoint(x: 0.24367*width, y: 0.08262*height))
        path.addCurve(to: CGPoint(x: 0.10668*width, y: 0.04571*height), control1: CGPoint(x: 0.19391*width, y: 0.10193*height), control2: CGPoint(x: 0.13486*width, y: 0.08582*height))
        path.addCurve(to: CGPoint(x: -0.07444*width, y: 0.03978*height), control1: CGPoint(x: 0.06644*width, y: -0.01156*height), control2: CGPoint(x: -0.02982*width, y: -0.01506*height))
        path.closeSubpath()
        return path
    }
}


struct TripBackgroundShape_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            ZStack {
                GeometryReader { geometry in
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.26, green: 0.26, blue: 0.26), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.08, green: 0.08, blue: 0.08), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                    TripBackgroundShape()
                        .fill(.white)
                        .opacity(0.04)
                        .offset(x: -100, y: 322)
                        .frame(width: geometry.size.width + 200)
                }
            }.ignoresSafeArea()
            
        )
    }
}
