//
//  ConfigurationValues.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import Foundation

enum ConfigurationValues {
    static var openWeatherAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAPIKey") as? String
        else { fatalError("OpenWeatherAPIKey is missing from Info.plist file.") }
        
        return key
    }
    
    static var openWeatherBaseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "OpenWeatherBaseURL") as? String
        else { fatalError("OpenWeatherBaseURL is missing from Info.plist file.") }
        
        return url
    }
}
