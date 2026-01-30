//
//  CurrentWeatherServiceProtocol.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

enum WeatherLocationInfo {
    case city(String)
    case latLong(Double, Double)
}

protocol CurrentWeatherServiceProtocol {
    func fetchCurrentWeather(with info: WeatherLocationInfo) async throws -> WeatherInformationViewDataModel
    
    @available(*, deprecated, message: "use fetchCurrentWeather(with:) instead")
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherInformationViewDataModel
    
    @available(*, deprecated, message: "use fetchCurrentWeather(with:) instead")
    func fetchCurrentWeather(city: String) async throws -> WeatherInformationViewDataModel
}
