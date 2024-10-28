//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView(Localization.loadingWeatherProgressView)
            .font(.largeTitle)
            .padding()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
