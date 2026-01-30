//
//  WeatherInformationScreenView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 12/01/2026.
//

import SwiftUI
import CoreLocation

struct WeatherInformationScreenView<ViewModel: WeatherInformationScreenViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 20) {
            WeatherLocationPickerView(selectedLocation: $viewModel.selectedLocation)

            content
        }
        .padding()
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {

        case .idle:
        Text("Please select a location")
                .foregroundColor(.secondary)

        case .loading:
            ProgressView("Loading selected weather...")

        case .loaded(let viewDataModel):
            WeatherInformationView(weatherInformationViewModel: viewDataModel)

        case .error(let message):
            VStack(spacing: 10) {
                Text("Error")
                    .font(.headline)
                Text(message)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#if DEBUG
class WeatherInformationScreenViewModelStub: WeatherInformationScreenViewModelProtocol {
    var state: WeatherInformationScreenState = .idle
    var showAlert: Bool = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    var selectedLocation: WeatherLocationDataModel = .currentLocation
}
#endif

#Preview(traits: .sizeThatFitsLayout) {
    let viewModel = WeatherInformationScreenViewModelStub()
    WeatherInformationScreenView(viewModel: viewModel)
}
