//
//  MockNetworkSession.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//


import Foundation

final class MockNetworkSession: NetworkSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {

        if let error {
            throw error
        }

        guard let data, let response else {
            throw URLError(.badServerResponse)
        }

        return (data, response)
    }
}
