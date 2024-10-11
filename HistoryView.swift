//
//  HistoryView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Пример контента - замените на ваши элементы
                ForEach(0..<20, id: \.self) { index in
                    HStack {
                        Text("History Item \(index + 1)")
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1)) // Устанавливаем серый фон
        .edgesIgnoringSafeArea(.bottom) // Опционально, чтобы фон растягивался до краёв экрана
        .navigationTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
