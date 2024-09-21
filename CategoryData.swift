//
//  CategoryData.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct CategoryInfo: Identifiable, Hashable {
    let id = UUID() // Уникальный идентификатор для каждой категории
    let name: String
    let icon: String
    let color: Color
    let fields: [CategoryField]
}

struct CategoryField: Hashable {
    let label: String
    let placeholder: String
    let keyboardType: UIKeyboardType
}

// Данные о категориях и их полях
struct CategoryData {
    // Поля для категорий
    static let categories: [CategoryInfo] = [
        CategoryInfo(
            name: "Art",
            icon: "paintpalette",
            color: .orange,
            fields: [
                CategoryField(label: "Currency", placeholder: "Select currency", keyboardType: .default),
                CategoryField(label: "Quantity", placeholder: "Enter quantity", keyboardType: .decimalPad),
                CategoryField(label: "Date", placeholder: "Select date", keyboardType: .default),
                CategoryField(label: "Comment", placeholder: "Add a comment", keyboardType: .default)
            ]
        ),
        CategoryInfo(
            name: "Cash",
            icon: "dollarsign.circle",
            color: .green,
            fields: [
                CategoryField(label: "Currency", placeholder: "Select currency", keyboardType: .default),
                CategoryField(label: "Quantity", placeholder: "Enter quantity", keyboardType: .decimalPad),
                CategoryField(label: "Date", placeholder: "Select date", keyboardType: .default),
                CategoryField(label: "Comment", placeholder: "Add a comment", keyboardType: .default)
            ]
        ),
        CategoryInfo(
            name: "Crypto",
            icon: "bitcoinsign.circle",
            color: .yellow,
            fields: [
                CategoryField(label: "Cryptocurrency", placeholder: "Select cryptocurrency", keyboardType: .default),
                CategoryField(label: "Quantity", placeholder: "Enter quantity", keyboardType: .decimalPad),
                CategoryField(label: "Date", placeholder: "Select date", keyboardType: .default),
                CategoryField(label: "Comment", placeholder: "Add a comment", keyboardType: .default)
            ]
        ),
        CategoryInfo(
            name: "Deposit",
            icon: "banknote",
            color: .blue,
            fields: [
                CategoryField(label: "Currency", placeholder: "Select currency", keyboardType: .default),
                CategoryField(label: "Quantity", placeholder: "Enter quantity", keyboardType: .decimalPad),
                CategoryField(label: "Date", placeholder: "Select date", keyboardType: .default),
                CategoryField(label: "Comment", placeholder: "Add a comment", keyboardType: .default)
            ]
        ),
        CategoryInfo(
            name: "Real Estate",
            icon: "house",
            color: .purple,
            fields: [
                CategoryField(label: "Currency", placeholder: "Select currency", keyboardType: .default),
                CategoryField(label: "Quantity", placeholder: "Enter quantity", keyboardType: .decimalPad),
                CategoryField(label: "Date", placeholder: "Select date", keyboardType: .default),
                CategoryField(label: "Comment", placeholder: "Add a comment", keyboardType: .default)
            ]
        ),
        CategoryInfo(
            name: "Transport",
            icon: "car", // Иконка для транспорта
            color: .gray,
            fields: [
                CategoryField(label: "Currency", placeholder: "Select currency", keyboardType: .default),
                CategoryField(label: "Quantity", placeholder: "Enter quantity", keyboardType: .decimalPad),
                CategoryField(label: "Date", placeholder: "Select date", keyboardType: .default),
                CategoryField(label: "Comment", placeholder: "Add a comment", keyboardType: .default)
            ]
        )
    ]
}
