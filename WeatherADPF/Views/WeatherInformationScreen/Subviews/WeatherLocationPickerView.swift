//
//  WeatherLocationPickerView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 12/01/2026.
//

import SwiftUI

struct WeatherLocationPickerView: View {
    @Binding var selectedLocation: WeatherLocationDataModel
    
    var body: some View {
        Picker("Location", selection: $selectedLocation) {
            ForEach(WeatherLocationDataModel.allCases) { location in
                Text(location.title)
                    .tag(location)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    @Previewable @State var selectedLocation: WeatherLocationDataModel = .montevideo
    WeatherLocationPickerView(selectedLocation: $selectedLocation)
}
