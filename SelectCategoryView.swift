//
//  SelectCategoryView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct SelectCategoryView: View {
    @Binding var selectedCategory: CategoryInfo?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List(CategoryData.categories, id: \.self) { category in
            Button(action: {
                selectedCategory = category
            }) {
                HStack {
                    Image(systemName: category.icon)
                    Text(category.name)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Select Category")
        .navigationBarItems(leading: Button("Close") {
            presentationMode.wrappedValue.dismiss()
        })
    }
}
