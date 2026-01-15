//
//  WeatherInformationScreenView.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 12/01/2026.
//

import SwiftUI
import CoreLocation

struct WeatherInformationScreenView: View {
    @StateObject private var viewModel: WeatherInformationScreenViewModel
    @StateObject private var locationManager = LocationManager()

    @State private var selectedLocation: WeatherLocationDataModel
    private let locationStorage = LocationStorage()

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    init(viewModel: WeatherInformationScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        let storedLocation = LocationStorage().loadLocation()
        _selectedLocation = State(initialValue: storedLocation ?? .buenosAires)
    }

    var body: some View {
        VStack(spacing: 20) {

            Picker("Location", selection: $selectedLocation) {
                ForEach(WeatherLocationDataModel.allCases) { location in
                    Text(location.title)
                        .tag(location)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedLocation) { location in
                handleLocationSelection(location)
                locationStorage.saveLocation(location)
            }

            content
        }
        .padding()
        .onAppear() {
            handleLocationSelection(selectedLocation)
        }
        .onChange(of: selectedLocation) { location in
            handleLocationSelection(location)
        }
        .onChange(of: locationManager.currentLocation) { location in
            guard selectedLocation == .currentLocation,
                  let location else { return }

            viewModel.loadCurrentWeather(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}

private extension WeatherInformationScreenView {
    func handleLocationSelection(_ location: WeatherLocationDataModel) {
        switch location {

        case .currentLocation:
            handleCurrentLocation()

        default:
            viewModel.loadCurrentWeather(for: location.cityQuery ?? "")
        }
    }

    func handleCurrentLocation() {
        switch locationManager.authorizationStatus {

        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestCurrentLocation()

        case .notDetermined:
            locationManager.requestLocationPermission()

        case .denied:
            showLocationAlert(
                title: "Location access denied",
                message: "You can enable location access in Settings."
            )

        case .restricted:
            showLocationAlert(
                title: "Location restricted",
                message: "Location access is restricted on this device."
            )

        @unknown default:
            break
        }
    }

    func showLocationAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

private extension WeatherInformationScreenView {
    @ViewBuilder
    var content: some View {
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
