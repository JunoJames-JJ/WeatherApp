//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation

struct WeatherData: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
