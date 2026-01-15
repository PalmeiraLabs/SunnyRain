//
//  TemperatureRangeItemView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct TemperatureRangeItemView: View {
    let temperatureText: String
    let title: String
    
    var body: some View {
        Text("\(title): \(temperatureText)° C")
            .font(.subheadline)
            .fontWeight(.semibold)
    }
}

#Preview {
    TemperatureRangeItemView(temperatureText: "12", title: "Min T.")
}
