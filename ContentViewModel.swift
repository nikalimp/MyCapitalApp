//
//  ContentViewModel.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var categories: [AssetCategory] = [
        AssetCategory(name: "Art", assets: []),
        AssetCategory(name: "Cash", assets: []),
        AssetCategory(name: "Crypto", assets: []),
        AssetCategory(name: "Deposit", assets: []),
        AssetCategory(name: "Real Estate", assets: []),
        AssetCategory(name: "Shares", assets: []),
        AssetCategory(name: "Transport", assets: [])
    ]
    
    @Published var expandedSections: [String: Bool] = [:]
    @Published var selectedCurrency = "USD"
    @Published var isPresentingAddNewAsset = false
    @Published var exchangeRates: [String: Double] = [:]
    private var cancellables = Set<AnyCancellable>()
    private var currencyService = CurrencyService()

    var totalAssets: Double {
        categories.flatMap { $0.assets }.reduce(0) { result, asset in
            result + (Double(asset.amount.replacingOccurrences(of: "$", with: "")) ?? 0)
        }
    }

    var assetAmounts: [Double] {
        categories.flatMap { category in
            category.assets.compactMap { asset in
                Double(asset.amount.replacingOccurrences(of: "$", with: "")) ?? 0
            }
        }
    }

    func refreshData() async {
        // Получаем актуальные курсы при обновлении экрана
        await currencyService.fetchCurrencyData()
            .sink(receiveCompletion: { _ in }, receiveValue: { })
            .store(in: &cancellables)
        
        // Здесь можно добавить логику для обновления данных активов
    }

    func convertedAmount(for asset: Asset) -> String? {
        guard let converter = currencyService.exchangeRates[selectedCurrency] else {
            return nil
        }
        let convertedAmount = CurrencyConverter(service: currencyService).convertAmount(asset.amount, from: "USD", to: selectedCurrency)
        return convertedAmount
    }
}
