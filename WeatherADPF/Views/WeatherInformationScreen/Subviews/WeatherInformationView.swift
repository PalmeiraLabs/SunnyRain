//
//  WeatherInformationView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct WeatherInformationView: View {
    @State private var isDescriptionExpanded = false
    
    let weatherInformationViewModel: WeatherInformationViewDataModel
    
    var body: some View {
        VStack(spacing: 25) {
            iconImageView
            
            Text(weatherInformationViewModel.city)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("\(weatherInformationViewModel.currentTemperature)° C")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            TemperatureRangeView(minTemperature: weatherInformationViewModel.minTemperature,
                                 maxTemperature: weatherInformationViewModel.maxTemperature)
            
            WeatherInformationDescriptionView(isDescriptionExpanded: isDescriptionExpanded,
                                              description: weatherInformationViewModel.description,
                                              onExpandButtonAction: { isDescriptionExpanded.toggle() } )
        }
    }
    
    init(weatherInformationViewModel: WeatherInformationViewDataModel) {
        self.weatherInformationViewModel = weatherInformationViewModel
    }
    
    @ViewBuilder
    private var iconImageView: some View {
        if let iconURL = weatherInformationViewModel.iconImageURL {
            AsyncImage(url: iconURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                case .failure:
                    Image(systemName: "cloud.fill")
                        .font(.largeTitle)
                    
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "cloud.fill")
                .font(.largeTitle)
        }
    }
}

#Preview {
    WeatherInformationView(weatherInformationViewModel:
                            WeatherInformationViewDataModel(city: "Buenos Aires",
                                                        iconImageURL: nil,
                                                        minTemperature: "10",
                                                        maxTemperature: "27",
                                                        currentTemperature: "22",
                                                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
}
