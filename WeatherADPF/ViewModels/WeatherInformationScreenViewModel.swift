//
//  WeatherInformationScreenViewModel.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation
import Combine

enum WeatherInformationScreenState {
    case idle
    case loading
    case loaded(WeatherInformationViewDataModel)
    case error(String)
}

protocol WeatherInformationScreenViewModelProtocol: ObservableObject {
    var state: WeatherInformationScreenState { get }
    var showAlert: Bool { get set }
    var alertTitle: String { get }
    var alertMessage: String { get }
    var selectedLocation: WeatherLocationDataModel { get set }
}

@MainActor
final class WeatherInformationScreenViewModel: WeatherInformationScreenViewModelProtocol {
    @Published private(set) var state: WeatherInformationScreenState = .idle
    @Published private(set) var alertTitle = ""
    @Published private(set) var alertMessage = ""
    @Published var showAlert = false
    @Published var selectedLocation: WeatherLocationDataModel = .currentLocation
    
    private let locationManager: LocationManagerProtocol
    private let locationStorage: LocationStorageProtocol
    private let currentWeatherService: CurrentWeatherServiceProtocol
    
    private var subscriptions: [AnyCancellable] = []
    
    init(currentWeatherService: CurrentWeatherServiceProtocol,
         locationManager: LocationManagerProtocol,
         locationStorage: LocationStorageProtocol) {
        self.currentWeatherService = currentWeatherService
        self.locationManager = locationManager
        self.locationStorage = LocationStorage()
        
        let storedLocation = locationStorage.loadLocation()
        _selectedLocation = Published(initialValue: storedLocation ?? .buenosAires)
        
        $selectedLocation
            .sink { newLocation in
                self.onSelectedLocationUpdate(newLocation)
            }
            .store(in: &subscriptions)
        
        locationManager.currentLocation
            .sink { newLocation in
                self.onCurrentLocationChanged(newLocation)
            }
            .store(in: &subscriptions)
    }
    
    private func onSelectedLocationUpdate(_ newLocation: WeatherLocationDataModel) {
        locationStorage.saveLocation(newLocation)
        
        if newLocation != .currentLocation {
            loadWeather(with:
                    .city(newLocation.cityQuery)
            )
        } else {
            requestCurrentLocationIfPossible()
        }
    }
    
    private func requestCurrentLocationIfPossible() {
        switch locationManager.authorizationStatus.value {
        case .notDetermined:
            locationManager.requestLocationPermission()
        case .valid:
            locationManager.requestCurrentLocation()
        case .notGranted:
            showLocationAlert(
                title: "Location access denied",
                message: "You can enable location access in Settings."
            )
        }
    }
    
    private func onCurrentLocationChanged(_ currentLocation: Location?) {
        guard let currentLocation else { return }
        
        guard selectedLocation == .currentLocation else { return }
        
        loadWeather(with:
                .latLong(
                    currentLocation.latitude,
                    currentLocation.longitude
                )
        )
    }
    
    private func loadWeather(with locationInput: WeatherLocationInfo) {
        Task{ @MainActor in
            state = .loading
            do {
                let response = try await self.currentWeatherService.fetchCurrentWeather(with: locationInput)
                state = .loaded(response)
            } catch {
                debugPrint(error.localizedDescription)
                state = .error("Couldn't obtain the weather.")
            }
        }
    }
    
    private func showLocationAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
