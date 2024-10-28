//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation

class LocationViewModel: ObservableObject {
    @Published var locationInput: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let lastSearchedLocationKey = "lastSearchedLocation"
    private var geocodingService = GeocodingService()
    
    var userLocationName: String?

    
    func searchLocation(modelData: ModelData) {
        errorMessage = nil
        
        guard !locationInput.isEmpty else {
            errorMessage = Localization.emptyLocationError
            return
        }
        
        isLoading = true
        modelData.fetchWeather(for: locationInput)
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.locationInput, forKey: self.lastSearchedLocationKey)
            self.isLoading = false
        }
    }
    
    func updateLocationInput(with name: String?) {
        if let name = name {
            locationInput = name // Update the text field with the current location name
        }
    }
    
    func loadLastSearchedLocation(modelData: ModelData) {
        if let lastLocation = UserDefaults.standard.string(forKey: lastSearchedLocationKey) {
            locationInput = lastLocation
            modelData.fetchWeather(for: lastLocation)
        }
    }
}

