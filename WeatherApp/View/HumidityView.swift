//
//  HumidityView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct HumidityView: View {
    let humidity: Double

    var body: some View {
        Text("Humidity: \(String(format: "%.2f", humidity))%")
            .font(.title3)
            .accessibilityLabel("Humidity level")
    }
}

