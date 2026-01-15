//
//  AlertView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//

import SwiftUI

struct AlertView: View {
    let title: String
    let message: String

    @State private var isPresented = true

    var body: some View {
        Color.clear
            .alert(title, isPresented: $isPresented) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(message)
            }
    }
}
