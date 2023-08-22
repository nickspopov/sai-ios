//
//  Color+HEX.swift
//  iosApp
//
//  Created by Николай Попов on 17.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
   init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
   }

   init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension Color {
    // Accent
    public static var accentBlue: Color {
        return Color(red: 56, green: 106, blue: 247)
    }
    public static var accentOrange: Color {
        return Color(red: 238, green: 86, blue: 40)
    }
    public static var blueSeven: Color {
        return Color(UIColor(red: 0.32, green: 0.48, blue: 0.98, alpha: 1))
    }
    public static var orangeSeven: Color {
        return Color(UIColor(red: 0.95, green: 0.37, blue: 0.2, alpha: 1))
    }
    public static var blueSix: Color {
        return Color(UIColor(red: 0.38, green: 0.53, blue: 0.97, alpha: 1))
    }
    public static var orangeSix: Color {
        return Color(UIColor(red: 0.95, green: 0.47, blue: 0.33, alpha: 1))
    }
    public static var blueFive: Color {
        return Color(UIColor(red: 0.53, green: 0.65, blue: 0.98, alpha: 1))
    }
    public static var orangeFive: Color {
        return Color(UIColor(red: 0.96, green: 0.6, blue: 0.49, alpha: 1))
    }
    public static var blueFour: Color {
        return Color(UIColor(red: 0.69, green: 0.77, blue: 0.99, alpha: 1))
    }
    public static var orangeFour: Color {
        return Color(UIColor(red: 0.97, green: 0.73, blue: 0.66, alpha: 1))
    }
    public static var blueThree: Color {
        return Color(UIColor(red: 0.77, green: 0.82, blue: 0.99, alpha: 1))
    }
    public static var orangeThree: Color {
        return Color(UIColor(red: 0.98, green: 0.8, blue: 0.75, alpha: 1))
    }
    public static var blueTwo: Color {
        return Color(UIColor(red: 0.84, green: 0.88, blue: 0.99, alpha: 1))
    }
    public static var orangeTwo: Color {
        return Color(UIColor(red: 0.99, green: 0.87, blue: 0.83, alpha: 1))
    }
    public static var blueOne: Color {
        return Color(UIColor(red: 0.92, green: 0.94, blue: 1, alpha: 1))
    }
    public static var orangeOne: Color {
        return Color(UIColor(red: 0.99, green: 0.93, blue: 0.92, alpha: 1))
    }
    
    // Success
    public static var success: Color {
        return Color(UIColor(red: 0.45, green: 0.62, blue: 0.25, alpha: 1))
    }
    
    // Warning
    public static var warning: Color {
        return Color(UIColor(red: 0.69, green: 0.39, blue: 0, alpha: 1))
    }
    
    // Error
    public static var error: Color {
        return Color(UIColor(red: 0.8, green: 0.1, blue: 0, alpha: 1))
    }
    
    // Info
    public static var info: Color {
        return Color(UIColor(red: 0.04, green: 0.28, blue: 0.68, alpha: 1))
    }
    
    // Grayscale
    public static var grayOne: Color {
        return Color(UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    }
    public static var grayTwo: Color {
        return Color(UIColor(red: 0.55, green: 0.58, blue: 0.68, alpha: 1))
    }
    public static var grayThree: Color {
        return Color(UIColor(red: 0.87, green: 0.87, blue: 0.94, alpha: 1))
    }
    public static var grayFour: Color {
        return Color(UIColor(red: 0.92, green: 0.92, blue: 0.97, alpha: 1))
    }
    public static var grayFive: Color {
        return Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    
}
