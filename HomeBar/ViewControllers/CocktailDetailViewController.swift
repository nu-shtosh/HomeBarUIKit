//
//  CocktailDetailViewController.swift
//  HomeBar
//
//  Created by Илья Дубенский on 30.10.2022.
//

import UIKit

class CocktailDetailViewController: UIViewController {
    
    @IBOutlet var cocktailNameLabel: UILabel!
    @IBOutlet var alcoholLabel: UILabel!
    
    @IBOutlet var cocktailImage: UIImageView!
    
    @IBOutlet var ingredientsTextView: UITextView!
    @IBOutlet var recipeTextView: UITextView!
    @IBOutlet var factTextView: UITextView!
    
    var cocktail: Cocktail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cocktailNameLabel.text = cocktail.name
        alcoholLabel.text = String(cocktail.alcohol)
        recipeTextView.text = cocktail.recipe
        factTextView.text = cocktail.info
        ingredientsTextView.text = cocktail.ingredients.joined(separator: ", ")
        cocktailImage.image = UIImage(named: cocktail.image)
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
