//
//  WeatherServiceConstants.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//


enum CurrentWeatherServiceConstants {
    enum Path {
        static let currentWeather = "/data/2.5/weather"
    }

    enum Query {
        static let city = "q"
        static let latitude = "lat"
        static let longitude = "lon"
        static let apiKey = "appid"
        static let units = "units"
        static let language = "lang"
    }

    enum Values {
        static let metricUnits = "metric"
        static let englishLanguage = "en"
    }
    
    enum HTTPStatus {
        static let successRange = 200...299
    }
}
