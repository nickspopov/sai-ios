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
    
    func toJSON() -> String {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(history)
        let result = String(data: data, encoding: .utf8)!
        return result
    }
    
    static func fromJSON(_ json: String) -> WalkHistory {
        let decoder = JSONDecoder()
        let data = json.data(using: .utf8)!
        let history = try! decoder.decode([Location].self, from: data)
        return WalkHistory(history: history)
    }
}

