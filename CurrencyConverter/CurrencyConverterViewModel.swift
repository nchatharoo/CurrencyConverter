//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Nadheer on 06/11/2024.
//

import Foundation

final class CurrencyConverterViewModel: ObservableObject {
    @Published var exchangeRates: [String: Double] = [:]
    @Published var errorMessage: String = ""

    private let currencyService: CurrencyServiceProtocol

    init(currencyService: CurrencyServiceProtocol = CurrencyService()) {
        self.currencyService = currencyService
    }

    func fetchRates() async {
        do {
            let rates = try await currencyService.getExchangeRates()
            DispatchQueue.main.async {
                self.exchangeRates = rates
                self.errorMessage = ""
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch exchange rates."
            }
        }
    }

    func convert(amount: Double, from: String, to: String) -> Double {
        guard let fromRate = exchangeRates[from.lowercased()], let toRate = exchangeRates[to.lowercased()] else {
            return 0.0
        }
        return (amount / fromRate) * toRate
    }
}
