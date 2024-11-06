//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Nadheer on 06/11/2024.
//

import Foundation

public protocol CurrencyServiceProtocol {
    func getExchangeRates() async throws -> [String: Double]
}

class CurrencyService: CurrencyServiceProtocol {
    func getExchangeRates() async throws -> [String: Double] {
        let url = URL(string: "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.json")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        do {
            struct CurrencyResponse: Decodable {
                let date: String
                let eur: [String: Double]
            }
            let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)
            return response.eur
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
}
