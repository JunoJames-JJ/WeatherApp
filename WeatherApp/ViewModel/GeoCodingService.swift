//
//  GeoCodingService.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation
import CoreLocation
import Combine

protocol GeocodingServiceProtocol {
    func fetchLocation(for locationName: String) -> AnyPublisher<CLLocationCoordinate2D, Error>
    func reverseGeocode(location: CLLocationCoordinate2D, completion: @escaping (String?) -> Void)
}

class GeocodingService: GeocodingServiceProtocol {
    private let geocoder = CLGeocoder()
    private let domainError = "GeocodingError"
    
    // Fetches geographical coordinates for given location.
    func fetchLocation(for locationName: String) -> AnyPublisher<CLLocationCoordinate2D, Error> {
        let subject = PassthroughSubject<CLLocationCoordinate2D, Error>()
        
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }

            guard let placemark = placemarks?.first, let location = placemark.location else {
                subject.send(completion: .failure(NSError(domain: self.domainError, code: 0,
                                                          userInfo: [NSLocalizedDescriptionKey: "No valid location found."])))
                return
            }

            subject.send(location.coordinate)
            subject.send(completion: .finished)
        }

        return subject.eraseToAnyPublisher()
    }

   // Reverse geocoding to convert geographical coordinates back to a location name.
    func reverseGeocode(location: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        geocoder.reverseGeocodeLocation(clLocation) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let placemark = placemarks?.first, let locationName = placemark.locality {
                completion(locationName)
            } else {
                completion(nil)
            }
        }
    }
}
