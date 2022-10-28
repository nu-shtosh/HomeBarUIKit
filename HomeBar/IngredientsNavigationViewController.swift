//
//  IngredientsNavigationViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//

import UIKit

class IngredientsNavigationViewController: UINavigationController {

    var ingredients: [Ingredient]!
    var cocktails: [Cocktail]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ingredientsVC = segue.destination as? IngredientsTableViewController else { return }
        ingredientsVC.ingredients = ingredients
        ingredientsVC.cocktails = cocktails
    }

}
