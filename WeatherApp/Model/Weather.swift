//
//  Weather.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation

struct Weather: Codable {
    var main: MainWeather
    var weather: [WeatherData]
    var name: String
    
    // Computed property to get the icon URL
        var iconURL: String? {
            guard let iconCode = weather.first?.icon else { return nil }
            return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
        }
}
