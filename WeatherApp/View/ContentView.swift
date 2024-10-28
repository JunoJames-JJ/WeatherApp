//
//  ContentView.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFahrenheit = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //Background color
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.6)]), startPoint: .topLeading, endPoint: .trailing)
                    .ignoresSafeArea()

                VStack(alignment: .leading) {
                    LocationView()
                    HStack {
                        Text(Date(), style: .date)
                            .font(.title3)
                        Spacer()
                        //Toggle to switch between Celcius and Fahrenheit units
                        Toggle(isOn: $showFahrenheit) {}
                        if showFahrenheit {
                            Text("F")
                        }
                        else {
                            Text("C")
                        }
                    }
                    //Current weather information
                    CurrentView(showFahrenheit: showFahrenheit)
                   
                    Spacer()
                }
                .padding(20)
                
                // Loading indicator centered in the middle of the screen
                if modelData.weathers == nil {
                    ProgressView("Data loading...")
                        .font(.title3)
                        .progressViewStyle(CircularProgressViewStyle())
                        .cornerRadius(10)
                        .padding(40)
                }

            }
            .navigationBarTitle("Weather Report")
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
