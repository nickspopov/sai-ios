//
//  TimeInterval+Extensions.swift
//  sai
//
//  Created by Николай Попов on 01.09.2023.
//

import Foundation


extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        if hours == 0 {
            return String(format: "%0.2d:%0.2d",minutes,seconds)
        }
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds)
    }
}
