//
//  CurrentWeatherResponseModel.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

struct CurrentWeatherResponseModel: Decodable {
    let weather: [WeatherItemModel]
    let main: MainModel
    let name: String
}

struct WeatherItemModel: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct MainModel: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like" //TODO: Use this value for showing it in the UI.
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
