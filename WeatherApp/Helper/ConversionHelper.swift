//
//  ConversionHelper.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation

class ConversionHelper {
    // Helper function to convert Celsius to Fahrenheit
    static func celciusToFahr(temp: Double) -> Double {
        return (temp * (9/5)) + 32
    }
    
    // Helper function to convert Fahrenheit to Celsius
    static func fahrToCelsius(temp: Double) -> Double {
        return (temp - 32) * (5/9)
    }
}
