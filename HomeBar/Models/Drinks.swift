//
//  Drinks.swift
//  HomeBar
//
//  Created by Aleksandr Mayyura on 29.10.2022.
//

import Foundation

struct Drink {
    let name: String
    let alcohol: Double
}

extension Drink {
    static func getIngredients() -> [Drink] {
        
        let drinksNames = DrinkDataStore.shared.drinks
        var drinks: [Drink] = []
        
        for (drinkName, alcohol) in drinksNames {
            let drink = Drink(name: drinkName, alcohol: alcohol)
            drinks.append(drink)
        }
        return drinks
    }
}
