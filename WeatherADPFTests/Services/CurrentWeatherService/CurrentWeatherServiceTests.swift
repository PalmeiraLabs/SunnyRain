//
//  CurrentWeatherServiceTests.swift
//  WeatherADPFTests
//
//  Created by Agustin Palmeira on 13/01/2026.
//

import XCTest
@testable import WeatherADPF

final class CurrentWeatherServiceTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testFetchCurrentWeatherSuccessNameShouldBeCorrect() async throws {
        // Given
        let mockSession = MockNetworkSession()
        let jsonData = try loadJSON(named: "CurrentWeatherServiceSuccessMockedResponse")
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let service = CurrentWeatherService(
            apiKey: "test_key",
            baseURL: "www.dummyURLADPF.com",
            session: mockSession
        )

        // When
        let response = try await service.fetchCurrentWeather(city: "Buenos Aires")

        // Then
        XCTAssertEqual(response.name, "Buenos Aires")
    }
    
    func testFetchCurrentWeatherSuccessTempShouldBeCorrect() async throws {
        // Given
        let mockSession = MockNetworkSession()
        let jsonData = try loadJSON(named: "CurrentWeatherServiceSuccessMockedResponse")
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let service = CurrentWeatherService(
            apiKey: "test_key",
            baseURL: "www.dummyURLADPF.com",
            session: mockSession
        )

        // When
        let response = try await service.fetchCurrentWeather(city: "Buenos Aires")

        // Then
        XCTAssertEqual(response.main.temp, 20.0)
    }
    
    func testFetchCurrentWeatherSuccessWeatherDescriptionShouldBeCorrect() async throws {
        // Given
        let mockSession = MockNetworkSession()
        let jsonData = try loadJSON(named: "CurrentWeatherServiceSuccessMockedResponse")
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let service = CurrentWeatherService(
            apiKey: "test_key",
            baseURL: "www.dummyURLADPF.com",
            session: mockSession
        )

        // When
        let response = try await service.fetchCurrentWeather(city: "Buenos Aires")

        // Then
        XCTAssertEqual(response.weather.first?.description, "scattered clouds")
    }
        
    func testFetchCurrentWeatherFailsIncorrectCity() async throws {
        // Given
        let mockSession = MockNetworkSession()
        let jsonData = try loadJSON(named: "CurrentWeatherServiceFailsMockedResponse")
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
            
        let service = CurrentWeatherService(
            apiKey: "test_key",
            baseURL: "www.dummyURLADPF.com",
            session: mockSession
        )

        // When - Then
        do {
            _ = try await service.fetchCurrentWeather(city: "FakeCity")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is CurrentWeatherServiceError)
        }
    }
}

private extension XCTestCase {

    func loadJSON(named name: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: "json")!
        return try Data(contentsOf: url)
    }
}
