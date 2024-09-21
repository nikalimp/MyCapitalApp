//
//  ContentView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    assetDiagram()
                    assetCategoriesList()
                }
                .refreshable {
                    // Обновляем данные при свайпе вниз
                    await viewModel.refreshData()
                }
                .onAppear {
                    // Обновляем данные при появлении экрана
                    Task {
                        await viewModel.refreshData()
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("MyCapital")
            .navigationBarItems(trailing: addNewAssetButton)
            .sheet(isPresented: $viewModel.isPresentingAddNewAsset) { // Открываем модальное окно
                AddAssetView(categories: $viewModel.categories) // Окно добавления актива
            }
        }
    }

    private var addNewAssetButton: some View {
        Button(action: {
            viewModel.isPresentingAddNewAsset = true // Меняем состояние, чтобы открыть окно
        }) {
            Image(systemName: "plus")
                .foregroundColor(.blue)
        }
    }

    @ViewBuilder
    private func assetDiagram() -> some View {
        if viewModel.totalAssets > 0 {
            PieChartView(data: viewModel.assetAmounts, totalAssets: viewModel.totalAssets)
                .frame(width: 250, height: 250)
                .padding()
        } else {
            Text("No assets yet")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
        }
    }

    @ViewBuilder
    private func assetCategoriesList() -> some View {
        ForEach(viewModel.categories) { category in
            if !category.assets.isEmpty {
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { viewModel.expandedSections[category.name] ?? false },
                        set: { viewModel.expandedSections[category.name] = $0 }
                    )
                ) {
                    ForEach(category.assets) { asset in
                        NavigationLink(destination: AssetDetailView(asset: Binding.constant(asset))) {
                            assetRow(asset: asset)
                        }
                    }
                } label: {
                    Text("\(category.name) (\(category.assets.count))")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
        }
    }

    @ViewBuilder
    private func assetRow(asset: Asset) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(asset.amount)
                    .font(.headline)
                    .foregroundColor(.black)
                if !asset.description.isEmpty {
                    Text(asset.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                if let convertedAmount = viewModel.convertedAmount(for: asset) {
                    Text("~\(convertedAmount) \(viewModel.selectedCurrency)")
                        .font(.headline)
                        .foregroundColor(.black)
                } else {
                    Text("Converting...")
                }
                Text(asset.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.vertical, 4)
    }
}
