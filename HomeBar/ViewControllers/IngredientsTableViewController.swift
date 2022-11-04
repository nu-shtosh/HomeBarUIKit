//
//  IngredientsTableViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    private var ingredients = Ingredient.getIngredients()
    private let cocktails = Cocktail.getCocktails()

    var selectedIngredients: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem?.isHidden = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            ingredients[indexPath.row].checkmarkState = false
            
            if let index = selectedIngredients.firstIndex(
                of: ingredients[indexPath.row].name
            ) {
                selectedIngredients.remove(at: index)
            }
            
            if selectedIngredients.isEmpty {
                navigationItem.rightBarButtonItem?.isHidden = true
            }
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            ingredients[indexPath.row].checkmarkState = true
            selectedIngredients.append(ingredients[indexPath.row].name)
            navigationItem.rightBarButtonItem?.isHidden = false
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

        cocktails.forEach { cocktail in
            let ingredientsInCocktail = cocktail.ingredients
            if !Set(selectedIngredients).isDisjoint(with: Set(ingredientsInCocktail)) {
                possibleCocktails.append(cocktail)
            }
        }
        return possibleCocktails
    }
}
