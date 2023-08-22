//
//  WalkHistory.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation


struct WalkHistory{
    var history: [Location]
    
    mutating func addLocation(_ location: Location) {
        history.append(location)
    }
}

