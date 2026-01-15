//
//  WeatherInformationViewDataModel.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import Foundation

struct WeatherInformationViewDataModel {
    let city: String
    let iconImageURL: URL?
    let minTemperature: String
    let maxTemperature: String
    let currentTemperature: String
    let description: String
    
    init(city: String,
         iconImageURL: URL?,
         minTemperature: String,
         maxTemperature: String,
         currentTemperature: String,
         description: String) {
        self.city = city
        self.iconImageURL = iconImageURL
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.currentTemperature = currentTemperature
        self.description = description
    }
}
