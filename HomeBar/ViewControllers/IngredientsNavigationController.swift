//
//  IngredientsNavigationController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 29.10.2022.
//

import UIKit

class IngredientsNavigationController: UINavigationController {

    var ingredients: [Ingredient] = []
    var cocktails: [Cocktail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToControllers(ingredients: ingredients, cocktails: cocktails)
    }

    private func transferDataToControllers(ingredients: [Ingredient], cocktails: [Cocktail]) {
        if let ingredientsTVC = topViewController as? IngredientsTableViewController {
            ingredientsTVC.ingredients = ingredients
            ingredientsTVC.cocktails = cocktails
        }
    }
}
