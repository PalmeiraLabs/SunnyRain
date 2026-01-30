//
//  CurrentWeatherService.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

class CurrentWeatherService: CurrentWeatherServiceProtocol {
    private let baseURL: String
    private let session: NetworkSessionProtocol
    
    init(baseURL: String = ConfigurationValues.openWeatherBaseURL,
        session: NetworkSessionProtocol = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func fetchCurrentWeather(with info: WeatherLocationInfo) async throws -> WeatherInformationViewDataModel {
        var builder = WeatherServiceQueryItemsBuilder()
        
        if case .city(let cityName) = info {
            debugPrint("Buscando por ciudad: \(cityName)")
            builder = builder.set(city: cityName)
        } else if case .latLong(let latitude, let longitude) = info {
            debugPrint("Buscando por lat/long")
            builder = builder.set(latitude: latitude)
                .set(longitude: longitude)
        }
        
        let queryItems = builder.build()
        
        guard let url = buildURL(path: CurrentWeatherServiceConstants.Path.currentWeather,
                                 queryItems: queryItems) else {
            throw CurrentWeatherServiceError.invalidURL
        }
        
        let response: CurrentWeatherResponseModel = try await performRequest(url: url)
        
        return WeatherInformationViewDataModelFactory(input: response).create()
    }
    
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherInformationViewDataModel {
        try await fetchCurrentWeather(with: .latLong(latitude, longitude))
    }
    
    func fetchCurrentWeather(city: String) async throws -> WeatherInformationViewDataModel {
        try await fetchCurrentWeather(with: .city(city))
    }
    
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            debugPrint("Tipo inválido de respuesta")
            throw CurrentWeatherServiceError.invalidResponse
        }
        
        guard CurrentWeatherServiceConstants.HTTPStatus.successRange.contains(httpResponse.statusCode) else {
            debugPrint("Código de estado inválido: \(httpResponse.statusCode)")
            throw CurrentWeatherServiceError.invalidResponse
        }

        guard (CurrentWeatherServiceConstants.HTTPStatus.successRange).contains(httpResponse.statusCode) else {
            throw CurrentWeatherServiceError.httpError(httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func buildURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        guard let baseURL = URL(string: baseURL) else {
            return nil
        }

        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = queryItems
        return components?.url
    }
}

struct WeatherInformationViewDataModelFactory {
    let input: CurrentWeatherResponseModel
    func create() -> WeatherInformationViewDataModel {
        WeatherInformationViewDataModel(
            city: input.name,
            iconImageURL: IconURLFactory(iconCodeString:  input.weather.first?.icon).create(),
            minTemperature: String(input.main.tempMin),
            maxTemperature: String(input.main.tempMax),
            currentTemperature: String(input.main.temp),
            description: input.weather.first?.description ?? ""
        )
    }
}

struct IconURLFactory {
    let iconCodeString: String?
    func create() -> URL? {
        guard let iconCodeString else { return nil }
        
        return URL(
            string: OpenWeatherConstants.Icon.baseURL
            + iconCodeString
            + OpenWeatherConstants.Icon.suffix
        )
    }
}
