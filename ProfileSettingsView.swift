//
//  ProfileSettingsView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct ProfileSettingsView: View {
    @AppStorage("selectedTheme") var selectedTheme: Int = 0 // 0 - System, 1 - Light, 2 - Dark
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    
    let currencies = ["USD", "EUR", "GBP", "JPY", "AUD"]
    let themes = ["System", "Light", "Dark"]
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(0..<themes.count) { index in
                        Text(themes[index]).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedTheme) { newValue in
                    switch newValue {
                    case 0:
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
                    case 1:
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                    case 2:
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                    default:
                        break
                    }
                }
            }
            
            Section(header: Text("Currency")) {
                Picker("Preferred Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Settings")
    }
}
