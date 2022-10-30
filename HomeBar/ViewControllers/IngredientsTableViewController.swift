//
//  IngredientsTableViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//

import UIKit

class IngredientsTableViewController: UITableViewController {

    // MARK: - Properties
    var ingredients: [Ingredient] = []
    var cocktails: [Cocktail] = []

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            ingredients[indexPath.row].checkmarkState = false
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            ingredients[indexPath.row].checkmarkState = true
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ingredient",
            for: indexPath
        )
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(
            red: 1,
            green: 0.216,
            blue: 0.373,
            alpha: 0.35
        )
        cell.selectedBackgroundView = backgroundView
        cell.accessoryType = .none
        cell.tintColor = UIColor(
            red: 1,
            green: 0.216,
            blue: 0.373,
            alpha: 1
        )
        let ingredient = ingredients[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = ingredient.name
        if ingredients[indexPath.row].checkmarkState {
            cell.accessoryType = .checkmark
        }
        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let possibleCocktails = findPossibleCocktails()
        guard let possibleCocktailsTVC = segue.destination as? PossibleCocktailsTableViewController else { return }
        possibleCocktailsTVC.possibleCocktails = possibleCocktails
    }

}

// MARK: - Private methods
extension IngredientsTableViewController {
    private func findPossibleCocktails() -> [Cocktail] {

        var possibleCocktails: [Cocktail] = []
        var selectedIngredients: [String] = []

        ingredients.forEach {
            if $0.checkmarkState == true {
                selectedIngredients.append($0.name)
            }
        }
        cocktails.forEach { cocktail in
            let ingredientsInCocktail = cocktail.ingredients
            if !Set(selectedIngredients).isDisjoint(with: Set(ingredientsInCocktail)) {
                possibleCocktails.append(cocktail)
            }
        }
        
        return possibleCocktails
    }
}
