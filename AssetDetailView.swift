//
//  AssetDetailView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct AssetDetailView: View {
    @Binding var asset: Asset
    @State private var isSaved = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Amount")) {
                TextField("Amount", text: $asset.amount)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Comment")) {
                TextField("Comment", text: $asset.description)
            }
            
            Section(header: Text("Date Added")) {
                DatePicker("Date", selection: $asset.date, displayedComponents: .date)
            }
            
            Button(action: {
                saveChanges()
            }) {
                Text(isSaved ? "Saved" : "Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(isSaved ? Color.green : Color.blue)
                    .cornerRadius(10)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Edit Asset")
        .navigationBarTitleDisplayMode(.inline)
    }

    func saveChanges() {
        isSaved = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
