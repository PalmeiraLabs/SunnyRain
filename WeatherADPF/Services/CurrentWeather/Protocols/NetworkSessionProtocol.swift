//
//  NetworkSessionProtocol.swift
//  WeatherADPF
//
//  Created by Agustin Palmeira on 13/01/2026.
//

import Foundation

protocol NetworkSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
