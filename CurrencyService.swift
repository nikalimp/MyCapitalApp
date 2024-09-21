//
//  CurrencyService.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import Foundation
import Combine

class CurrencyService: ObservableObject {
    @Published var exchangeRates: [String: Double] = [:]  // Курс валют
    @Published var supportedCurrencies: [String] = []     // Список фиатных валют
    @Published var supportedCryptocurrencies: [String] = [] // Список криптовалют
    @Published var errorMessage: String?
    
    private let apiKey = "48FONPZN1G8AZB2D" // Ваш Alpha Vantage API ключ
    
    // Функция для получения курса валют
    func fetchCurrencyData() -> AnyPublisher<Void, Never> {
        // Временно задаем статический список поддерживаемых валют для отображения в интерфейсе
        self.supportedCurrencies = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "CHF", "CNY", "INR", "RUB"]
        print("Using static currency list for testing")
        return Just(()).eraseToAnyPublisher() // Возвращаем пустое значение для завершения работы
    }
    
    // Функция для получения списка криптовалют
    func fetchCryptoData() -> AnyPublisher<Void, Never> {
        // Используем статический список криптовалют для отображения в интерфейсе
        self.supportedCryptocurrencies = ["BTC", "ETH", "LTC", "XRP", "ADA", "BNB", "DOT", "SOL", "DOGE", "AVAX"]
        print("Using static cryptocurrency list for testing")
        return Just(()).eraseToAnyPublisher() // Возвращаем пустое значение для завершения работы
    }
}

// Модели данных для ответа по курсу валют
struct AlphaVantageCurrencyResponse: Codable {
    let rateInfo: ExchangeRateInfo

    enum CodingKeys: String, CodingKey {
        case rateInfo = "Realtime Currency Exchange Rate"
    }
}

struct ExchangeRateInfo: Codable {
    let fromCurrencyCode: String
    let fromCurrencyName: String
    let toCurrencyCode: String
    let toCurrencyName: String
    let exchangeRate: String
    let lastRefreshed: String

    enum CodingKeys: String, CodingKey {
        case fromCurrencyCode = "1. From_Currency Code"
        case fromCurrencyName = "2. From_Currency Name"
        case toCurrencyCode = "3. To_Currency Code"
        case toCurrencyName = "4. To_Currency Name"
        case exchangeRate = "5. Exchange Rate"
        case lastRefreshed = "6. Last Refreshed"
    }
}

// Модель данных для ответа по криптовалютам
struct AlphaVantageCryptoResponse: Codable {
    let cryptoList: [CryptoInfo]

    enum CodingKeys: String, CodingKey {
        case cryptoList = "data" // Если нужно уточнить, используйте сырой ответ
    }
}

struct CryptoInfo: Codable {
    let symbol: String
    let name: String
}
