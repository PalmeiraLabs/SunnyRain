//
//  CurrentWeatherService.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

class CurrentWeatherService: CurrentWeatherServiceProtocol {
    let apiKey: String
    let baseURL: String
    let session: NetworkSessionProtocol
    
    init(
        apiKey: String = ConfigurationValues.openWeatherAPIKey,
        baseURL: String = ConfigurationValues.openWeatherBaseURL,
        session: NetworkSessionProtocol = URLSession.shared
    ) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.session = session
    }
    
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> CurrentWeatherResponseModel {
        let queryItems = commonQueryItems + [URLQueryItem(name: CurrentWeatherServiceConstants.Query.latitude,
                                                          value: String(latitude)),
                                             URLQueryItem(name: CurrentWeatherServiceConstants.Query.longitude,
                                                          value: String(longitude))
        ]
        
        guard let url = buildURL(path: CurrentWeatherServiceConstants.Path.currentWeather,
                                 queryItems: queryItems) else {
            throw CurrentWeatherServiceError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
    
    func fetchCurrentWeather(city: String) async throws -> CurrentWeatherResponseModel {
        let queryItems = commonQueryItems + [URLQueryItem(name: CurrentWeatherServiceConstants.Query.city,
                                                          value: city)
        ]
        
        guard let url = buildURL(path: CurrentWeatherServiceConstants.Path.currentWeather,
                                 queryItems: queryItems) else {
            throw CurrentWeatherServiceError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
}
