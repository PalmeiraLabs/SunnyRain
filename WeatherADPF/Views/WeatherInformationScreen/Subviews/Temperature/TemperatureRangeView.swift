//
//  TemperatureRangeView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct TemperatureRangeView: View {
    let minTemperature: String
    let maxTemperature: String
    
    var body: some View {
        HStack(spacing: 50) {
            TemperatureRangeItemView(temperatureText: minTemperature, title: "Min T.")
            TemperatureRangeItemView(temperatureText: maxTemperature, title: "Max T.")
        }
    }
}

#Preview {
    TemperatureRangeView(minTemperature: "17", maxTemperature: "26")
}
