//
//  RoundedCorner.swift
//  sai
//
//  Created by Николай Попов on 10.09.2023.
//

import Foundation
import SwiftUI

struct RoundedCornerShape: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
