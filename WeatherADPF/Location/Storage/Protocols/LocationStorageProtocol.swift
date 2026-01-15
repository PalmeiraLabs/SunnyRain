//
//  LocationStorageProtocol.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//

import Foundation

protocol LocationStorageProtocol {
    func saveLocation(_ location: WeatherLocationDataModel)
    func loadLocation() -> WeatherLocationDataModel?
}
