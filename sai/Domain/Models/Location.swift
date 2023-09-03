//
//  Location.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation
import MapKit

struct Location: Codable {
    var latitude: Double
    var longitude: Double
    var timestamp: Date
    
    func distance(to otherLocation: Location) -> Double {
        return toCLLocation().distance(from: otherLocation.toCLLocation())
    }
    
    func toCLLocation() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
