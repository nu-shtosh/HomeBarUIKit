//
//  TabBarViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//
import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Properties
    private let ingredients = Ingredient.getIngredients()
    private let cocktails = Cocktail.getCocktails()

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToControllers(
            ingredients: ingredients,
            cocktails: cocktails
        )
    }

    // MARK: - Navigation
    private func transferDataToControllers(
        ingredients: [Ingredient],
        cocktails: [Cocktail]
    ) {
        viewControllers?.forEach { viewController in
            if let ingredientsNVC = viewController as? IngredientsNavigationController {
                ingredientsNVC.ingredients = ingredients
                ingredientsNVC.cocktails = cocktails
            }
        }
    }
}
