//
//  ModelData.swift
//  WeatherApp
//
//  Created by Juno James on 2024-10-28.
//

import Foundation
import Combine
import CoreLocation

class ModelData: ObservableObject {
    @Published var weathers: Weather?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    private let geocodingService: GeocodingServiceProtocol

    private let lastWeatherDataKey = "lastWeatherData"

    // Dependency Injection through initializer
    init(weatherService: WeatherServiceProtocol = WeatherService(),
         geocodingService: GeocodingServiceProtocol = GeocodingService()) {
        self.weatherService = weatherService
        self.geocodingService = geocodingService
        loadLastWeatherData()
    }
    
    // Load last weather data from UserDefaults if available
    func loadLastWeatherData() {
        if let lastWeatherData = UserDefaults.standard.object(forKey: lastWeatherDataKey) as? Data {
            do {
                let decoder = JSONDecoder()
                weathers = try decoder.decode(Weather.self, from: lastWeatherData)
            } catch {
                print(Localization.loadLastWeatherError)
            }
        }
    }

    // Display an error msg when geocoding fails.
    func showGeocodingError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.weathers = nil
        }
    }
    
    // Fetch weather for a given location name
    func fetchWeather(for locationName: String) {
        guard !locationName.isEmpty else {
            showGeocodingError(Localization.emptyLocationError)
            weathers = nil
            return
        }

        isLoading = true
        geocodingService.fetchLocation(for: locationName)
            .flatMap { [weak self] coordinate -> AnyPublisher<Weather, Error> in
                guard let self = self else {
                    return Fail(error: NSError(domain: "ModelDataError", code: 0,
                                               userInfo: [NSLocalizedDescriptionKey: Localization.modelDataNotAvailable]))
                    .eraseToAnyPublisher()
                }
                return self.loadWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(_) = completion {
                    self?.showError(Localization.dataFetchError)
                }
            }, receiveValue: { [weak self] weatherData in
                self?.weathers = weatherData
                self?.saveWeatherData(weatherData) // Save weather data
            })
            .store(in: &cancellables)
    }
    
    // Load weather data for given lat and long.
    private func loadWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<Weather, Error> {
        isLoading = true
        return weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .eraseToAnyPublisher()
    }

    // Displays generic error msg.
    private func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
    
    // Save fetched weather data to UserDefaults.
    private func saveWeatherData(_ weatherData: Weather) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(weatherData)
            UserDefaults.standard.set(data, forKey: lastWeatherDataKey)
        } catch {
            print(Localization.saveWeatherError)
        }
    }
}

