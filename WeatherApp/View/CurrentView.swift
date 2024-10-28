//
//  CurrentView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct CurrentView: View {
    @EnvironmentObject var modelData: ModelData
    let showFahrenheit: Bool
    
    var body: some View {
        VStack {
            if modelData.isLoading {
                LoadingView()
            } else if let weather = modelData.weathers {
                WeatherDetailsView(weather: weather, showFahrenheit: showFahrenheit)
            } else {
                // Use the existing ErrorMessage view
                ErrorMessage(errorMessage: $modelData.errorMessage)
            }
        }
        .padding()
    }
}


