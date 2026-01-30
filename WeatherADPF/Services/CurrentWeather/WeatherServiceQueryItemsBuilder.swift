//
//  WeatherServiceQueryItemsBuilder.swift
//  WeatherADPF
//
//  Created by Luis David Goyes Garces on 30/01/26.
//

import Foundation

class WeatherServiceQueryItemsBuilder {
    private let apiKey: String
    private var queryItems = [URLQueryItem]()
    
    init(apiKey: String = ConfigurationValues.openWeatherAPIKey) {
        self.apiKey = apiKey
        
        appendCommonQueryItems()
    }
    
    private func appendCommonQueryItems() {
        queryItems.append(contentsOf: [
            URLQueryItem(name: CurrentWeatherServiceConstants.Query.apiKey,
                         value: apiKey),
            URLQueryItem(name: CurrentWeatherServiceConstants.Query.units,
                         value: CurrentWeatherServiceConstants.Values.metricUnits),
            URLQueryItem(name: CurrentWeatherServiceConstants.Query.language,
                         value: CurrentWeatherServiceConstants.Values.englishLanguage)
        ])
    }
    
    func set(city: String) -> Self {
        queryItems.append(URLQueryItem(name: CurrentWeatherServiceConstants.Query.city, value: city))
        return self
    }
    
    func set(latitude: Double) -> Self {
        queryItems.append(URLQueryItem(name: CurrentWeatherServiceConstants.Query.latitude, value: String(latitude)))
        return self
    }
    
    func set(longitude: Double) -> Self {
        queryItems.append(URLQueryItem(name: CurrentWeatherServiceConstants.Query.longitude, value: String(longitude)))
        return self
    }
    
    func build() -> [URLQueryItem] {
        queryItems
    }
}
