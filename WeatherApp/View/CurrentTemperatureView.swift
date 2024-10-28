//
//  CurrentTemperatureView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct CurrentTemperatureView: View {
    let temp: Double
    let showFahrenheit: Bool

    var body: some View {
        Text("Current Temp: \(showFahrenheit ? String(format: "%.0f", ConversionHelper.celciusToFahr(temp: temp)) + "°F" : String(format: "%.0f", temp) + "°C")")
            .font(.title)
            .fontWeight(.bold)
            .accessibilityLabel("Current temperature")
    }
}

