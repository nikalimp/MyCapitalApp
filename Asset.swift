//
//  Asset.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import Foundation

struct Asset: Identifiable {
    var id = UUID()
    var icon: String
    var amount: String
    var currency: String
    var description: String
    var category: String
    var date: Date
}
