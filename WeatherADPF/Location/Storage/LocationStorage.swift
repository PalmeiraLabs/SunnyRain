//
//  LocationStorage.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//

import Foundation

class LocationStorage: LocationStorageProtocol {
    private let key = "lastSelectedWeatherLocation"

    func saveLocation(_ location: WeatherLocationDataModel) {
        UserDefaults.standard.set(location.rawValue, forKey: key)
    }

    func loadLocation() -> WeatherLocationDataModel? {
        guard
            let rawValue = UserDefaults.standard.string(forKey: key),
            let location = WeatherLocationDataModel(rawValue: rawValue)
        else {
            return nil
        }

        return location
    }
}
