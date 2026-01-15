//
//  CurrentWeatherServiceProtocol.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

protocol CurrentWeatherServiceProtocol {
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> CurrentWeatherResponseModel
    func fetchCurrentWeather(city: String) async throws -> CurrentWeatherResponseModel
}
