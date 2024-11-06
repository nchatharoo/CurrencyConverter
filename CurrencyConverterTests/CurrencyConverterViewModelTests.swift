//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Nadheer on 06/11/2024.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyConverterViewModelTests: XCTestCase {
    var viewModel: CurrencyConverterViewModel!
    var mockService: MockCurrencyService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockCurrencyService()
        viewModel = CurrencyConverterViewModel(currencyService: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        try super.tearDownWithError()
    }

    func testFetchRatesSuccess() async throws {
        mockService.shouldReturnError = false
        await viewModel.fetchRates()
        XCTAssertTrue(viewModel.errorMessage.isEmpty, "Error message should be empty on successful fetch")
        XCTAssertGreaterThan(viewModel.exchangeRates.count, 0, "Exchange rates should contain values on successful fetch")
    }

    func testFetchRatesFailure() async throws {
        mockService.shouldReturnError = true
        await viewModel.fetchRates()
        XCTAssertFalse(viewModel.errorMessage.isEmpty, "Error message should not be empty on fetch failure")
        XCTAssertEqual(viewModel.exchangeRates.count, 0, "Exchange rates should be empty on fetch failure")
    }

    func testConvertCurrencyValidRates() async throws {
        mockService.shouldReturnError = false
        await viewModel.fetchRates()
        let conversionResult = viewModel.convert(amount: 100, from: "USD", to: "EUR")
        XCTAssertNotEqual(conversionResult, 0.0, "Conversion result should not be zero for valid input")
        XCTAssertGreaterThan(conversionResult, 0, "Conversion result should be greater than zero for valid input")
    }

    func testConvertCurrencyInvalidRates() throws {
        let conversionResult = viewModel.convert(amount: 100, from: "XYZ", to: "ABC")
        XCTAssertEqual(conversionResult, 0.0, "Conversion result should be zero for invalid currency codes")
    }

    func testConvertCurrencySameCurrency() throws {
        let conversionResult = viewModel.convert(amount: 100, from: "USD", to: "USD")
        XCTAssertEqual(conversionResult, 100.0, "Conversion result should be the same as input amount for the same currency")
    }
}
