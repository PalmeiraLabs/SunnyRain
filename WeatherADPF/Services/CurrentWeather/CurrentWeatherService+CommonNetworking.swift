//
//  CurrentWeatherService+Networking.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 09/01/2026.
//

import Foundation

extension CurrentWeatherService {
    var commonQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: CurrentWeatherServiceConstants.Query.apiKey,
                         value: apiKey),
            URLQueryItem(name: CurrentWeatherServiceConstants.Query.units,
                         value: CurrentWeatherServiceConstants.Values.metricUnits),
            URLQueryItem(name: CurrentWeatherServiceConstants.Query.language,
                         value: CurrentWeatherServiceConstants.Values.englishLanguage)
        ]
    }

    func buildURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        guard let baseURL = URL(string: baseURL) else {
            return nil
        }

        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = queryItems
        return components?.url
    }

    func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (CurrentWeatherServiceConstants.HTTPStatus.successRange).contains(httpResponse.statusCode) else {
            throw CurrentWeatherServiceError.invalidResponse
        }

        guard (CurrentWeatherServiceConstants.HTTPStatus.successRange).contains(httpResponse.statusCode) else {
            throw CurrentWeatherServiceError.httpError(httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
