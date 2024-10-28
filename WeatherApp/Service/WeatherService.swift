//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<Weather, Error>
}

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "0d6bc7639dacbd17179631b3e1236c14" // Add API Key in here..
    
    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<Weather, Error> {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)")
        else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

