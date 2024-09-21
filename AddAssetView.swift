//
//  AddAssetView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct AddAssetView: View {
    @Binding var categories: [AssetCategory]
    @StateObject private var currencyService = CurrencyService()
    @State private var selectedCategory: CategoryInfo? = CategoryData.categories.first
    @State private var assetQuantity: String = ""
    @State private var assetDate = Date()
    @State private var comment: String = ""
    @State private var selectedCurrency: String = "USD"
    @State private var selectedCrypto: String = ""
    @State private var customFieldValues: [String: String] = [:] // Для хранения значений произвольных полей
    @Environment(\.presentationMode) var presentationMode

    var isFormValid: Bool {
        return !assetQuantity.isEmpty && selectedCategory != nil
    }

    var body: some View {
        NavigationView {
            Form {
                // Секция для выбора категории
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(CategoryData.categories, id: \.self) { category in
                            Text(category.name).tag(category as CategoryInfo?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Динамическое отображение полей для выбранной категории
                if let selectedCategory = selectedCategory {
                    Section(header: Text("Information")) {
                        ForEach(selectedCategory.fields, id: \.label) { field in
                            switch field.label {
                            case "Currency":
                                Picker(field.placeholder, selection: $selectedCurrency) {
                                    ForEach(currencyService.supportedCurrencies, id: \.self) { currency in
                                        Text(currency).tag(currency)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                
                            case "Cryptocurrency":
                                Picker(field.placeholder, selection: $selectedCrypto) {
                                    ForEach(currencyService.supportedCryptocurrencies, id: \.self) { crypto in
                                        Text(crypto).tag(crypto)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                
                            case "Quantity":
                                TextField(field.placeholder, text: $assetQuantity)
                                    .keyboardType(field.keyboardType)
                                    
                            case "Date":
                                DatePicker(field.placeholder, selection: $assetDate, displayedComponents: .date)
                                
                            case "Comment":
                                TextField(field.placeholder, text: $comment)
                                
                            default:
                                // Для произвольных полей создаем текстовое поле
                                TextField(field.placeholder, text: Binding(
                                    get: { customFieldValues[field.label] ?? "" },
                                    set: { customFieldValues[field.label] = $0 }
                                ))
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Asset")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveAsset()
                }
                .disabled(!isFormValid)
            )
            .onAppear {
                // Загружаем статические списки валют и криптовалют
                currencyService.fetchCurrencyData()
                currencyService.fetchCryptoData()
            }
        }
    }

    func saveAsset() {
        guard let selectedCategory = selectedCategory else { return }
        let newAsset = Asset(
            icon: selectedCategory.icon,
            amount: assetQuantity,
            currency: selectedCategory.name == "Crypto" ? selectedCrypto : selectedCurrency,
            description: comment,
            category: selectedCategory.name,
            date: assetDate
        )
        if let index = categories.firstIndex(where: { $0.name == selectedCategory.name }) {
            categories[index].assets.append(newAsset)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
