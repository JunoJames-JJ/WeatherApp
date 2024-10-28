//
//  WeatherDescriptionView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct WeatherDescriptionView: View {
    let description: String

    var body: some View {
        Text(description.capitalized)
            .font(.title2)
    }
}


