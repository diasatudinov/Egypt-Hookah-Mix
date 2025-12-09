//
//  FlavorType.swift
//  Egypt Hookah Mix
//
//


import SwiftUI


enum FlavorType: String, Codable, CaseIterable, Identifiable {
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

enum CreatedFlavorType: Codable {
    case own
    case fromList
}

struct CreatedFlavor: Codable, Identifiable, Hashable {
    let id = UUID()
    let selectedFlavors: [FlavorType]
    let title: String
    let productName: String
    var createdType: CreatedFlavorType
    var isFavorite: Bool
    var isEvaluated: Bool
    var proportion: Int
    var fortress: Int
    var time: String
    var myRating: Int
    var notes: String
}


final class FlavorViewModel: ObservableObject {
    @Published var selectedFlavors: [FlavorType] = []
    @Published var createdFlavors: [CreatedFlavor] = [
        
    ] {
        didSet {
            saveCreatedFlavors()
        }
    }
    
    private var createdFlavorsfileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("habits.json")
    }
    
    init() {
        loadCreatedFlavors()
    }
    
    
    private func saveCreatedFlavors() {
        let url = createdFlavorsfileURL
        do {
            let data = try JSONEncoder().encode(createdFlavors)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadCreatedFlavors() {
        let url = createdFlavorsfileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let createdFlavors = try JSONDecoder().decode([CreatedFlavor].self, from: data)
            self.createdFlavors = createdFlavors
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    private static let combinationMap: [String: String] = [
        "Sweet": "Vanilla Dream",
        "Citrus": "Citrus Zest",
        "Minty": "Arctic Breeze",
        "Fruity": "Tropical Escape",
        "Berry": "Summer Berries",
        "Floral": "Garden Bloom",
        "Dessert": "Midnight Mocha",
        "Spicy": "Golden Spice",
        
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
    
    func toggleSelection(_ flavor: FlavorType) {
        if selectedFlavors.contains(flavor) {
            selectedFlavors.removeAll { $0 == flavor }
        } else {
            guard selectedFlavors.count < 3 else { return }
            selectedFlavors.append(flavor)
        }
    }
    
    func createFlavor(createdType: CreatedFlavorType, ownProductName: String = "", newProportion: Int = 0, newFortress: Int = 0, newTime: String = "", newMyRating: Int = 0, newNotes: String = "") {
        guard !selectedFlavors.isEmpty else { return }
        
        let ordered = FlavorType.allCases.filter { selectedFlavors.contains($0) }
        let key = ordered.map { $0.rawValue }.joined(separator: " + ")
        var productName = ""
        var isEvaluated = false
        var proportion = 0
        var fortress = 0
        var time = ""
        var myRating = 0
        var notes = ""
        
        if createdType == .fromList {
            productName = Self.combinationMap[key] ?? "Unknown blend"
        } else {
            productName = ownProductName
            proportion = newProportion
            fortress = newFortress
            time = newTime
            myRating = newMyRating
            notes = newNotes
            isEvaluated = true
        }
        let newFlavor = CreatedFlavor(
            selectedFlavors: ordered,
            title: key,
            productName: productName,
            createdType: createdType,
            isFavorite: false,
            isEvaluated: isEvaluated,
            proportion: proportion,
            fortress: fortress,
            time: time,
            myRating: myRating,
            notes: notes
        )
        
        createdFlavors.append(newFlavor)
        selectedFlavors.removeAll()
    }
    
    func getFlavors(for productName: String) -> [FlavorType] {
        guard let combinationKey = Self.combinationMap.first(where: { $0.value == productName })?.key else {
            return []
        }
        
        let names = combinationKey.components(separatedBy: " + ")
        let flavors = names.compactMap { FlavorType(rawValue: $0) }
        return flavors
    }
    
    func toggleIsFavorite(_ flavor: CreatedFlavor) {
        if let index = createdFlavors.firstIndex(where: { $0.id == flavor.id }) {
            createdFlavors[index].isFavorite.toggle()
        }
    }
    
    func evaluateFlavor(_ flavor: CreatedFlavor, proportion: Int, fortress: Int, time: String, myRating: Int, notes: String) {
        if let index = createdFlavors.firstIndex(where: { $0.id == flavor.id }) {
            createdFlavors[index].proportion = proportion
            createdFlavors[index].fortress = fortress
            createdFlavors[index].time = time
            createdFlavors[index].myRating = myRating
            createdFlavors[index].notes = notes
            createdFlavors[index].isEvaluated = true
        }
    }
}
