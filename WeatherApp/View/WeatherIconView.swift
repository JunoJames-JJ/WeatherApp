//
//  WeatherIconView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct WeatherIconView: View {
    let iconCode: String?

    var body: some View {
        if let iconCode = iconCode {
            let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: iconURL)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    Image(systemName: "cloud")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
            } else {
                // Fallback for earlier versions
                Image(systemName: "cloud")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
        }
    }
}


