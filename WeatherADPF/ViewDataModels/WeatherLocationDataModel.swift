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
        return switch self {
        case .currentLocation: "Current location"
        case .london: "London"
        case .montevideo: "Montevideo"
        case .buenosAires: "Buenos Aires"
        }
    }

    var cityQuery: String {
        return switch self {
        case .currentLocation: ""
        case .london: "London"
        case .montevideo: "Montevideo"
        case .buenosAires: "Buenos Aires"
        }
    }
}
