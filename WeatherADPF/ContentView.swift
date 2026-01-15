//
//  ContentView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherInformationScreenViewModel(currentWeatherService: CurrentWeatherService())
                                                                           
    var body: some View {
        WeatherInformationScreenView(viewModel: viewModel)
        .padding()
    }
}

#Preview {
    ContentView()
}
