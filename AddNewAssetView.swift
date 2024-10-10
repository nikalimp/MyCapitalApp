//
//  AddNewAssetView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 10.10.2024.
//

import SwiftUI

struct AddNewAssetView: View {
    @Binding var categories: [AssetCategory]
    var selectedCategory: CategoryInfo
    @State private var assetQuantity: String = ""
    @State private var assetDate = Date()
    @State private var comment: String = ""
    var onBack: () -> Void // Новый параметр для возврата к выбору категорий
    
    var isFormValid: Bool {
        return !assetQuantity.isEmpty
    }
    
    var body: some View {
        Form {
            Section(header: Text("Category: \(selectedCategory.name)")) {
                ForEach(selectedCategory.fields, id: \.label) { field in
                    if field.label == "Quantity" {
                        TextField(field.placeholder, text: $assetQuantity)
                            .keyboardType(field.keyboardType)
                    } else if field.label == "Date" {
                        DatePicker(field.placeholder, selection: $assetDate, displayedComponents: .date)
                    } else if field.label == "Comment" {
                        TextField(field.placeholder, text: $comment)
                    }
                }
            }
        }
        .navigationTitle("New Active")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            onBack() // Возвращаемся к экрану выбора категорий
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        }, trailing: Button("Save") {
            saveAsset()
        }.disabled(!isFormValid))
    }
    
    func saveAsset() {
        guard let index = categories.firstIndex(where: { $0.name == selectedCategory.name }) else { return }
        
        let newAsset = Asset(icon: selectedCategory.icon, amount: assetQuantity, currency: "USD", description: comment, category: selectedCategory.name, date: assetDate)
        categories[index].assets.append(newAsset)
    }
}
