//
//  LocationManager.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//

import CoreLocation
import Foundation
import Combine

struct Location {
    let latitude, longitude: Double
}

enum AuthorizationStatus {
    case valid, notDetermined, notGranted
}

protocol LocationManagerProtocol {
    var authorizationStatus:  CurrentValueSubject<AuthorizationStatus, Never> { get }
    var currentLocation: CurrentValueSubject<Location?, Never> { get }
    func requestLocationPermission()
    func requestCurrentLocation()
}

struct CLAuthorizationStatusMapper {
    let status: CLAuthorizationStatus
    func mapToAuthorizationStatus() -> AuthorizationStatus {
        return switch status {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
                .valid
        case .notDetermined:
                .notDetermined
        case .restricted, .denied:
            fallthrough
        @unknown default:
                .notGranted
        }
    }
}

final class LocationManager: NSObject, LocationManagerProtocol {
    private(set) var authorizationStatus:  CurrentValueSubject<AuthorizationStatus, Never>
    private(set) var currentLocation: CurrentValueSubject<Location?, Never>
    private let manager: CLLocationManager
    
    override init() {
        manager = CLLocationManager()
        authorizationStatus = .init(CLAuthorizationStatusMapper(status: manager.authorizationStatus).mapToAuthorizationStatus())
        currentLocation = .init(nil)
        super.init()
        manager.delegate = self
    }
    
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestCurrentLocation() {
        manager.requestLocation()
    }
}

extension LocationManager: @MainActor CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        self.authorizationStatus.send(CLAuthorizationStatusMapper(status: status).mapToAuthorizationStatus())
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.manager.requestLocation()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        
        self.currentLocation.send(Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Location error:", error.localizedDescription)
    }
}
