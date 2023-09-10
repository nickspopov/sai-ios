//
//  CGFloar+Extension.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import Foundation
import CoreGraphics

extension CGFloat {
    func interpolate(_ from: [CGFloat], _ to: [CGFloat]) -> CGFloat {
        guard from.count == to.count, from.count > 1 else {
            fatalError("Arrays must have the same length and contain at least two elements")
        }
        
        if self <= from.first! {
            return to.first!
        }
        
        if self >= from.last! {
            return to.last!
        }
        
        var i = 0
        while i < from.count - 1 {
            if self >= from[i] && self <= from[i+1] {
                break
            }
            i += 1
        }
        
        let progress = (self - from[i]) / (from[i+1] - from[i])
        return to[i] + progress * (to[i+1] - to[i])
    }
}
