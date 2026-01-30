//
//  WeatherInformationDescriptionView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct WeatherInformationDescriptionView: View {
    @State private var expanded = false
    @State private var truncated = false
    let description: String
    
    private func computeDescriptionBoundingRect(in geometry: GeometryProxy) -> CGRect {
        description.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16)
            ],
            context: nil
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(description)
                .multilineTextAlignment(.center)
                .font(.body.italic())
                .lineLimit(expanded ? nil : 2)
                .animation(.easeInOut, value: expanded)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                let total = computeDescriptionBoundingRect(in: geometry)
                                
                                if total.size.height > geometry.size.height {
                                    self.truncated = true
                                }
                            }
                    }
                )
            
            if truncated {
                Button {
                    expanded.toggle()
                } label: {
                    Image(systemName: expanded ? "minus.circle" : "plus.circle")
                }
                .accessibilityLabel(
                    expanded
                    ? "Hide weather description"
                    : "Show weather description"
                )
            }
        }
    }
}

#Preview("More than 5 lines") {
    WeatherInformationDescriptionView(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
}

#Preview("Less than 2 lines") {
    WeatherInformationDescriptionView(description: "Lorem ipsum dolor sit amet.")
}
