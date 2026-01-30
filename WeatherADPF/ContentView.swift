//
//  ContentView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct WeatherInformationScreenFactory {
    static func create() -> some View {
        let currentWeatherService = CurrentWeatherService()
        let locationManager = LocationManager()
        let locationStorage = LocationStorage()
        let viewModel = WeatherInformationScreenViewModel(currentWeatherService: currentWeatherService, locationManager: locationManager, locationStorage: locationStorage)
        
        return WeatherInformationScreenView(viewModel: viewModel)
    }
}

struct ContentView: View {
    var body: some View {
        WeatherInformationScreenFactory.create()
            .padding()
    }
}

#Preview {
    ContentView()
}

