//
//  Cocktail.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//

struct Cocktail {
    let name: String
    let alcohol: Double
    let ingredients: [String]
    let recipe: String
    let info: String
}

extension Cocktail: Equatable {
    static func getCocktails() -> [Cocktail] {
        [
            Cocktail(
                name: "Белый Русский",
                alcohol: 20,
                ingredients: [
                    "Сливки",
                    "Водка",
                    "Кофейный ликер",
                    "Лед"
                ],
                recipe: "Закинуть в стакан лед, добавить ингредиенты, перемешать",
                info: "Стал популярным после фильма \"Большой Лебовски\""
            )
        ]
    }
}

struct Ingredient {
    let name: String
    var checkmarkState: Bool
}

extension Ingredient {
    static func getIngredients() -> [Ingredient] {
        let ingredientsNames = DataStore.shared.ingredients.sorted()
        var ingredients: [Ingredient] = []
        for ingredientName in ingredientsNames {
            let ingredient = Ingredient(
                name: ingredientName,
                checkmarkState: false
            )
            ingredients.append(ingredient)
        }
        return ingredients
    }
}
