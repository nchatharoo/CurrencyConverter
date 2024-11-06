//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Nadheer on 06/11/2024.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyConverterTests: XCTestCase {
    var mockService: MockCurrencyService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockCurrencyService()
    }

    override func tearDownWithError() throws {
        mockService = nil
        try super.tearDownWithError()
    }

    func testMockServiceReturnsValidRates() async throws {
        mockService.shouldReturnError = false
        let rates = try await mockService.getExchangeRates()
        XCTAssertGreaterThan(rates.count, 0, "Mock service should return valid rates when no error is set")
    }

    func testMockServiceThrowsError() async throws {
        mockService.shouldReturnError = true
        do {
            _ = try await mockService.getExchangeRates()
            XCTFail("Mock service should throw an error when shouldReturnError is true")
        } catch {
            XCTAssertTrue(error is URLError, "Error should be of type URLError")
        }
    }
}
