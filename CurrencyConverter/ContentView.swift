//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Nadheer on 06/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: CurrencyConverterViewModel
    @State private var amount: String = ""
    @State private var fromCurrency: String = "EUR"
    @State private var toCurrency: String = "USD"
    @State private var result: Double = 0.0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                HStack {
                    TextField("From", text: $fromCurrency)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("To", text: $toCurrency)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Button("Convert") {
                    if let amount = Double(amount) {
                        result = viewModel.convert(amount: amount, from: fromCurrency, to: toCurrency)
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Text("Result: \(result, specifier: "%.2f")")
                    .font(.headline)

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Currency Converter")
            .task {
                await viewModel.fetchRates()
            }
        }
    }
}
