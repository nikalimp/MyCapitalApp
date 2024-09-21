//
//  CurrencyConverter.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import Foundation

struct CurrencyConverter {
    var service: CurrencyService
    
    func convertAmount(_ amount: String, from baseCurrency: String, to targetCurrency: String) -> String {
        guard let amountValue = Double(amount.replacingOccurrences(of: "$", with: "")) else { return "$0" }
        
        let baseRate = service.exchangeRates[baseCurrency] ?? 1.0
        let targetRate = service.exchangeRates[targetCurrency] ?? 1.0
        
        let convertedAmount = (amountValue / baseRate) * targetRate
        return String(format: "%.2f", convertedAmount)
    }
}
