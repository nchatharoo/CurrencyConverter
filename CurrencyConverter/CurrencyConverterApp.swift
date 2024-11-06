//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Nadheer on 06/11/2024.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CurrencyConverterViewModel())
        }
    }
}
