//
//  MainTabView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                ContentView()
                    .navigationTitle("MyCapital")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Assets")
            }

            NavigationView {
                HistoryView()
                    .navigationTitle("History")
            }
            .tabItem {
                Image(systemName: "clock")
                Text("History")
            }

            NavigationView {
                ProfileSettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
        .accentColor(.blue)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
