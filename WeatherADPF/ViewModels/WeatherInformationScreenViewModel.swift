//
//  WeatherInformationScreenViewModel.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

enum WeatherInformationScreenState {
    case idle
    case loading
    case loaded(WeatherInformationViewDataModel)
    case error(String)
}

@MainActor
final class WeatherInformationScreenViewModel: ObservableObject {
    @Published private(set) var state: WeatherInformationScreenState = .idle

    private let currentWeatherService: CurrentWeatherServiceProtocol

    init(currentWeatherService: CurrentWeatherServiceProtocol) {
        self.currentWeatherService = currentWeatherService
    }

    func loadCurrentWeather(for city: String) {
        state = .loading
        load {
            try await self.currentWeatherService.fetchCurrentWeather(city: city)
        }
    }

    func loadCurrentWeather(latitude: Double, longitude: Double) {
        state = .loading
        load {
            try await self.currentWeatherService.fetchCurrentWeather(
                latitude: latitude,
                longitude: longitude
            )
        }
    }
}

private extension WeatherInformationScreenViewModel {
    func load(
        request: @escaping () async throws -> CurrentWeatherResponseModel
    ) {
        state = .loading

        Task {
            do {
                let response = try await request()
                let viewDataModel = mapToViewDataModel(response)
                state = .loaded(viewDataModel)
            } catch {
                state = .error("Couldn't obtain the weather.")
            }
        }
    }
}

private extension WeatherInformationScreenViewModel {
    func mapToViewDataModel(
        _ response: CurrentWeatherResponseModel
    ) -> WeatherInformationViewDataModel {

        WeatherInformationViewDataModel(
            city: response.name,
            iconImageURL: makeIconURLFromString(response.weather.first?.icon),
            minTemperature: String(response.main.tempMin),
            maxTemperature: String(response.main.tempMax),
            currentTemperature: String(response.main.temp),
            description: response.weather.first?.description ?? ""
        )
    }

    func makeIconURLFromString(_ iconCodeString: String?) -> URL? {
        guard let iconCodeString else { return nil }

        return URL(
            string: OpenWeatherConstants.Icon.baseURL
            + iconCodeString
            + OpenWeatherConstants.Icon.suffix
        )
    }
}
