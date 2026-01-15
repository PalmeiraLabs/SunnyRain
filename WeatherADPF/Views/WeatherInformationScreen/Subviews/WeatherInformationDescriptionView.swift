//
//  WeatherInformationDescriptionView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 08/01/2026.
//

import SwiftUI

struct WeatherInformationDescriptionView: View {
    let isDescriptionExpanded: Bool
    let description: String
    let onExpandButtonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(description)
                .multilineTextAlignment(.center)
                .font(.body.italic())
                .lineLimit(isDescriptionExpanded ? nil : 2)
                .animation(.easeInOut, value: isDescriptionExpanded)
            
            if shouldShowExpandButton {
                Button(action: onExpandButtonAction) {
                    Image(systemName: isDescriptionExpanded ? "minus.circle" : "plus.circle")
                }
                .accessibilityLabel(
                    isDescriptionExpanded
                    ? "Hide weather description"
                    : "Show weather description"
                )
            }}
    }
    
    //TODO: Should implement a better solution to detect if the text has many lines.
    private var shouldShowExpandButton: Bool {
        description
            .split(separator: " ")
            .count > 5
    }

}

/*
#Preview {
    @Previewable @State var isExpanded = false
    WeatherInformationDescriptionView(isDescriptionExpanded: isExpanded,
                                      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", onExpandButtonAction: {
        isExpanded.toggle() } )
}
*/
