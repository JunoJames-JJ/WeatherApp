//
//  ErrorMessage.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct ErrorMessage: View {
    @Binding var errorMessage: String?

    var body: some View {
        if let errorMessage = errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
        }
    }
}


