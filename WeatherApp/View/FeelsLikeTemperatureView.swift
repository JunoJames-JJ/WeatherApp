//
//  FeelsLikeTemperatureView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct FeelsLikeTemperatureView: View {
    let temp: Double
    let showFahrenheit: Bool

    var body: some View {
        Text("Feels Like: \(showFahrenheit ? String(format: "%.0f", ConversionHelper.celciusToFahr(temp: temp)) + "°F" : String(format: "%.0f", temp) + "°C")")
            .font(.title3)
            .accessibilityLabel("Feels like temperature")
    }
}


