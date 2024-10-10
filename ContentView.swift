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
            .navigationTitle("Assets")
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
            VStack {
                Image("Tolstoy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                Text("True freedom is the ability to control one’s desires")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                
                Text("Lev Nikolayevich Tolstoy")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                
                Button(action: {
                    viewModel.isPresentingAddNewAsset = true // Открываем окно добавления нового актива
                }) {
                    Text("Add asset")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .padding(.vertical, 4)
    }
}
