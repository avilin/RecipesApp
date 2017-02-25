//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

// MARK: - Lifecycle
class RecipesViewController: UITableViewController {

    var recipesPresenter: RecipesPresenter?
    var recipes: [RecipeCellViewData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        recipesPresenter?.attachView(recipesView: self)
        recipesPresenter?.loadRecipes()
    }

}

// MARK: - RecipesView
extension RecipesViewController: RecipesView {

    func setRecipes(recipes: [RecipeCellViewData]) {
        self.recipes = recipes
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension RecipesViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeViewCell.cellID, for: indexPath) as?
            RecipeViewCell else {
            print("There was an error loading the cell")
            fatalError()
        }

        let recipe = recipes[indexPath.row]
        cell.thumbnailImageView.image = recipe.image
        cell.nameLabel.text = recipe.name
        cell.timeLabel.text = recipe.time
        cell.ingredientesNumberLabel.text = recipe.ingredients

        return cell
    }

}
