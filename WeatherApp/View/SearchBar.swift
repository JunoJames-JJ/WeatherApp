//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct SearchBar: View {
    @Binding var locationInput: String
    var searchAction: () -> Void

    var body: some View {
        HStack {
            TextField(Localization.locationEnterTextField, text: $locationInput, onCommit: searchAction)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(locationInput.isEmpty ? Color.clear : Color.red.opacity(0.2))

            Button(action: searchAction) {
                Image(systemName: "magnifyingglass")
                    .padding()
            }
            .accessibilityLabel("Search location")
        }
    }
}


