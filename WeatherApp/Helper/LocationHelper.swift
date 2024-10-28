//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation
import CoreLocation

struct LocationHelper {
 
    static func isSameLocation(_ location1: CLLocationCoordinate2D, _ location2: CLLocationCoordinate2D?) -> Bool {
        guard let loc2 = location2 else { return false }
        return location1.latitude == loc2.latitude && location1.longitude == loc2.longitude
    }

    static func stringFromCoordinate(_ location: CLLocationCoordinate2D) -> String {
        return "\(location.latitude),\(location.longitude)"
    }
    
    static func coordinateFromString(_ coordinateString: String) -> CLLocationCoordinate2D? {
        let components = coordinateString.split(separator: ",")
        guard components.count == 2,
              let latitude = Double(components[0]),
              let longitude = Double(components[1]) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
