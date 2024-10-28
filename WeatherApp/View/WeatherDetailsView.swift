//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct WeatherDetailsView: View {
    let weather: Weather
    let showFahrenheit: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            CurrentTemperatureView(temp: weather.main.temp, showFahrenheit: showFahrenheit)
            WeatherIconView(iconCode: weather.weather.first?.icon)
            WeatherDescriptionView(description: weather.weather[0].description)
            FeelsLikeTemperatureView(temp: weather.main.feels_like, showFahrenheit: showFahrenheit)
            HumidityView(humidity: Double(weather.main.humidity))
        }
        .padding()
    }
}


