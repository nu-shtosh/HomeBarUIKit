//
//  PossibleCocktailsTableViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 28.10.2022.
//

import UIKit

class PossibleCocktailsTableViewController: UITableViewController {
    
    var possibleCocktails: [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationBarSettings()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        possibleCocktails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "possibleCocktail",
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
        let cocktail = possibleCocktails[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = cocktail.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cocktailDetailVC = segue.destination as? CocktailDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        cocktailDetailVC.cocktail = possibleCocktails[indexPath.row]
    }
}

extension PossibleCocktailsTableViewController {
    private func navigationBarSettings(){
        title = "Коктейли"
        navigationItem.backBarButtonItem?.tintColor = .red
    }
}
