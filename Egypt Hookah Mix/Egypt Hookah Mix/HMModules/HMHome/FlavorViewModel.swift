//
//  FlavorType.swift
//  Egypt Hookah Mix
//
//  Created by Dias Atudinov on 09.12.2025.
//


import SwiftUI

// MARK: - Model

enum FlavorType: String, CaseIterable, Identifiable {
    case sweet = "Sweet"
    case citrus = "Citrus"
    case minty = "Minty"
    case fruity = "Fruity"
    case berry = "Berry"
    case floral = "Floral"
    case dessert = "Dessert"
    case spicy = "Spicy"
    
    var id: String { rawValue }
}

struct CreatedFlavor: Identifiable, Hashable {
    let id = UUID()
    let title: String        // "Sweet + Citrus"
    let productName: String  // "Citrus Swirl"
}

// MARK: - ViewModel

final class FlavorViewModel: ObservableObject {
    @Published var selectedFlavors: [FlavorType] = []
    @Published var createdFlavors: [CreatedFlavor] = []
    
    // Таблица соответствий из задания
    private static let combinationMap: [String: String] = [
        // ОДИН ВКУС
        "Sweet": "Vanilla Dream",
        "Citrus": "Citrus Zest",
        "Minty": "Arctic Breeze",
        "Fruity": "Tropical Escape",
        "Berry": "Summer Berries",
        "Floral": "Garden Bloom",
        "Dessert": "Midnight Mocha",
        "Spicy": "Golden Spice",
        
        // ПАРЫ
        "Sweet + Citrus": "Citrus Swirl",
        "Sweet + Minty": "Frosty Caramel",
        "Sweet + Fruity": "Peach Crème",
        "Sweet + Berry": "Berry Custard",
        "Sweet + Floral": "Rose Caramel",
        "Sweet + Dessert": "Tiramisu Cloud",
        "Sweet + Spicy": "Spiced Caramel",
        
        "Citrus + Minty": "Mojito Fresh",
        "Citrus + Fruity": "Citrus Orchard",
        "Citrus + Berry": "Berry Citrus Splash",
        "Citrus + Floral": "Jasmine Sunrise",
        "Citrus + Dessert": "Mocha Citrus",
        "Citrus + Spicy": "Ginger Sunrise",
        
        "Minty + Fruity": "Melon Frost",
        "Minty + Berry": "Berry Chill",
        "Minty + Floral": "Lavender Breeze",
        "Minty + Dessert": "Mint Mocha",
        "Minty + Spicy": "Spiced Mint",
        
        "Fruity + Berry": "Orchard Berry",
        "Fruity + Floral": "Peach Blossom",
        "Fruity + Dessert": "Tiramisu Peach",
        "Fruity + Spicy": "Spiced Pineapple",
        
        "Berry + Floral": "Roseberry",
        "Berry + Dessert": "Chocolate Berry",
        "Berry + Spicy": "Spiced Berry",
        
        "Floral + Dessert": "Lavender Mocha",
        "Floral + Spicy": "Spiced Rose",
        
        "Dessert + Spicy": "Cinnamon Mocha",
        
        // ТРОЙКИ
        "Sweet + Citrus + Minty": "Citrus Frost Swirl",
        "Sweet + Fruity + Berry": "Summer Crème",
        "Citrus + Fruity + Minty": "Tropical Mojito",
        "Fruity + Berry + Floral": "Blossom Berry",
        "Minty + Dessert + Spicy": "Spiced Mocha Chill",
        "Sweet + Citrus + Dessert": "Orange Caramel Mocha",
        "Citrus + Berry + Spicy": "Spiced Citrus Berry",
        "Fruity + Floral + Spicy": "Spiced Peach Bloom",
        "Sweet + Minty + Floral": "Frosty Rose Dream",
        "Berry + Dessert + Citrus": "Berry Mocha Splash",
        "Sweet + Fruity + Spicy": "Spiced Peach Crème",
        "Citrus + Minty + Spicy": "Ginger Lime Frost",
        "Sweet + Citrus + Fruity": "Citrus Cream Dream",
        "Minty + Fruity + Spicy": "Spiced Melon Breeze",
        "Berry + Floral + Dessert": "Roseberry Mocha",
        "Sweet + Berry + Spicy": "Spiced Berry Custard",
        "Citrus + Dessert + Spicy": "Spiced Orange Mocha",
        "Fruity + Dessert + Floral": "Peach Lavender Tiramisu",
        "Sweet + Minty + Dessert": "Frosty Tiramisu",
        "Berry + Minty + Spicy": "Spiced Berry Frost",
        "Sweet + Fruity + Floral": "Peach Rose Crème",
        "Citrus + Fruity + Spicy": "Spiced Citrus Tropical",
        "Minty + Floral + Spicy": "Spiced Lavender Breeze",
        "Sweet + Citrus + Spicy": "Spiced Citrus Caramel"
    ]
    
    // Выбор / снятие выбора вкуса (макс. 3)
    func toggleSelection(_ flavor: FlavorType) {
        if selectedFlavors.contains(flavor) {
            selectedFlavors.removeAll { $0 == flavor }
        } else {
            guard selectedFlavors.count < 3 else { return }
            selectedFlavors.append(flavor)
        }
    }
    
    // Создать новый blend из выбранных вкусов
    func createFlavor() {
        guard !selectedFlavors.isEmpty else { return }
        
        // Ключ всегда в одном порядке (как в enum), чтобы совпадать с таблицей
        let ordered = FlavorType.allCases.filter { selectedFlavors.contains($0) }
        let key = ordered.map { $0.rawValue }.joined(separator: " + ")
        
        let productName = Self.combinationMap[key] ?? "Unknown blend"
        
        let newFlavor = CreatedFlavor(
            title: key,
            productName: productName
        )
        
        createdFlavors.append(newFlavor)
        selectedFlavors.removeAll()
    }
}