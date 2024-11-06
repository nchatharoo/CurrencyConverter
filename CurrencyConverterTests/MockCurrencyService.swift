//
//  MockCurrencyService.swift
//  CurrencyConverterTests
//
//  Created by Nadheer on 06/11/2024.
//

import Foundation
import CurrencyConverter

public class MockCurrencyService: CurrencyServiceProtocol {
    var shouldReturnError = false

    func getExchangeRates() async throws -> [String: Double] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return ["USD": 1.0, "EUR": 0.85, "GBP": 0.75]
    }
}

