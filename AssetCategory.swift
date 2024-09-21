//
//  AssetCategory.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import Foundation

struct AssetCategory: Identifiable {
    var id = UUID() // Уникальный идентификатор категории
    var name: String
    var assets: [Asset]
}
