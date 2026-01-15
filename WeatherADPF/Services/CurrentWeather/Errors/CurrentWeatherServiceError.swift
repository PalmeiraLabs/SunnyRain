//
//  CurrentWeatherServiceError.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//


enum CurrentWeatherServiceError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case invalidLocation
}
