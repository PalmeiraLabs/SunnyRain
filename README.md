//
//  README.md
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//

# WeatherADPF ☀️🌧️

An iOS weather application built with **SwiftUI**, **MVVM**, **Swift Concurrency**, and **CoreLocation**, using the **OpenWeather API**.

This project focuses on clean architecture, separation of concerns, and modern iOS development best practices.

- OpenWeather site: https://openweathermap.org/

---

## ✨ Features

- 🌍 Fetch current weather by:
  - Selected city
  - User’s current location
- 📍 Location permission handling (authorized / denied / restricted)
- Async network calls using `async/await`
- State-driven UI with clear loading & error handling
- 💾 Persistence of last selected location
- Clean separation between:
  - Networking
  - Domain models
  - View models
  - UI views

---

## Architecture

The app follows **MVVM (Model–View–ViewModel)** with a clear responsibility split.

```
View
 └── observes → ViewModel
        ├── handles UI state
        ├── calls Services
        └── maps API models → ViewDataModels
Service
 └── performs API requests
Model
 └── API response models (Decodable)
```

---

## 📂 Project Structure

Note: I didn't add all the classes & folders below, it's just for showing the main project structure.

```
WeatherADPF
│
├── Services
│   ├── CurrentWeatherService
│   ├── CurrentWeatherServiceProtocol
│   └── CurrentWeatherServiceConstants
│
├── Location
│   └── LocationManager
│   └── LocationStorage
│
├── Models
│   ├── CurrentWeatherResponseModel
│   └── WeatherLocationDataModel
│
├── ViewDataModels
│   ├── WeatherInformationViewDataModel
│   └── WeatherLocationDataModel
│
├── ViewModels
│   └── WeatherInformationScreenViewModel
│
├── Views
│   └── Common
│   │    └── AlertView
│   └── WeatherInformationScreen
│        └── Subviews
│        │    ├── Temperature
│        │    │    ├──  TemperatureRangeItemView
│        │    │    └── TemperatureRangeView
│        │    ├── WeatherInformationDescriptionView
│        │    ├── WeatherInformationView
│        │    └── WeatherLocationPickerView
│        └── WeatherInformationScreenView
│
├── Info.plist
├── SecretsConfig.xcconfig
│
├── WeatherADPFApp
└── ContentView
```

---

## State Management

The main screen is driven by a **state enum**:

```swift
enum WeatherInformationScreenState {
    case idle
    case loading
    case loaded(WeatherInformationViewDataModel)
    case error(String)
}
```

---

## Networking

- Uses `URLSession` with `async/await`
- Centralized URL building
- Generic `performRequest<T: Decodable>()`
- Proper HTTP status validation

---

## 📍 Location Handling

Location access is managed by a dedicated `LocationManager`.

- Requests permission explicitly
- Listens to CoreLocation callbacks
- Updates UI safely on the **MainActor**

---

## 🔐 API Key & Configuration

Sensitive values are handled via:

- `SecretsConfig.xcconfig`: The api key must be configured here. You can get it from https://home.openweathermap.org/api_keys.
- `Info.plist`

---

## Requirements

- iOS 15+
- Xcode 15+
- Swift 5.9+
- OpenWeather API key

---

## 👨‍💻 Author

Agustin Daniel Palmeira.

E-mail: agustin.palmeira.it@gmail.com
