//
//  WeatherLocationDataModel.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 12/01/2026.
//


enum WeatherLocationDataModel: String, Identifiable, CaseIterable {
    case currentLocation
    case london
    case montevideo
    case buenosAires

    var id: String { rawValue }

    var title: String {
        switch self {
        case .currentLocation: return "Current location"
        case .london: return "London"
        case .montevideo: return "Montevideo"
        case .buenosAires: return "Buenos Aires"
        }
    }

    var cityQuery: String? {
        switch self {
        case .currentLocation: return nil
        case .london: return "London"
        case .montevideo: return "Montevideo"
        case .buenosAires: return "Buenos Aires"
        }
    }
}
