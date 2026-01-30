//
//  WeatherIcon.swift
//  WeatherADPF
//
//  Created by Luis David Goyes Garces on 30/01/26.
//

import SwiftUI

struct WeatherIcon: View {
    let iconURL: URL?
    
    var body: some View {
        if let iconURL {
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

#Preview("No icon", traits: .sizeThatFitsLayout) {
    WeatherIcon(iconURL: nil)
}

#Preview("Some icon", traits: .sizeThatFitsLayout) {
    WeatherIcon(iconURL: URL(string: "https://t3.ftcdn.net/jpg/17/74/99/30/240_F_1774993062_egTYQ2SyNLTCyfvuex2M4PYHvqYgpwWe.jpg"))
}
