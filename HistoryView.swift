//
//  HistoryView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct HistoryView: View {
    @State private var totalAssets: Double = 50000 // Пример значения
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            analyticsBlock()
            Text("History of changes will be displayed here.")
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle("History")
    }

    @ViewBuilder
    private func analyticsBlock() -> some View {
        HStack(alignment: .top, spacing: 20) {
            VStack {
                Text("Total Assets")
                    .font(.headline)
                Text("$\(Int(totalAssets))")
                    .font(.largeTitle)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)

            VStack {
                Text("Growth (%)")
                    .font(.headline)
                Text("5.0%")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }
        .padding(.horizontal)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
