//
//  LocationView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    @EnvironmentObject var modelData: ModelData
    @StateObject private var viewModel = LocationViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            SearchBar(locationInput: $viewModel.locationInput, searchAction: {
                viewModel.searchLocation(modelData: modelData)
            })
            .padding()
            
            ErrorMessage(errorMessage: $viewModel.errorMessage)
            
            if viewModel.isLoading {
                ProgressView(Localization.loadingProgress)
            }
        }
        .onAppear {
            viewModel.loadLastSearchedLocation(modelData: modelData)
            locationManager.fetchUserLocation()
        }

        .onChange(of: modelData.errorMessage) { error in
            viewModel.errorMessage = error
        }
        
        .onReceive(locationManager.$userLocation) { newLocation in
            if let location = newLocation {
                let locationString = LocationHelper.stringFromCoordinate(location)
                modelData.fetchWeather(for: locationString)
                viewModel.updateLocationInput(with: locationManager.userLocationName) // Update input with location name
            }
        }
        .onReceive(locationManager.$userLocationName) { newLocationName in
            viewModel.updateLocationInput(with: newLocationName) // Populate text field with location name
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
