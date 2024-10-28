//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var userLocationName: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocationAccess()
    }

    // Request location access from user
    func requestLocationAccess() {
        locationManager.requestWhenInUseAuthorization()
    }

    // Handle changes in authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    // Handle successful location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location.coordinate

        }
    }

    // Handle location update errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    // Method to fetch user's location
    func fetchUserLocation() {
        locationManager.requestLocation() 
    }
    
   
}
