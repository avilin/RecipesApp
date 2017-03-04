//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {

    var recipesPresenter: RecipesPresenter!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        recipesPresenter.attachView(recipesView: self)
        recipesPresenter.initView()
    }

}

// MARK: - Navigation
extension RecipesViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailViewController = segue.destination as? RecipeDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            recipesPresenter.configure(view: recipeDetailViewController, withRecipeAt: indexPath)
        }
    }

}

// MARK: - RecipesView
extension RecipesViewController: RecipesView {

    func reloadData() {
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension RecipesViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return recipesPresenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesPresenter.numberOfRows(inSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.cellID, for: indexPath) as?
            RecipeCell else {
            print("There was an error loading the cell")
            fatalError()
        }

        let recipeCellDTO = recipesPresenter.recipeCellDTO(for: indexPath)
        cell.configure(with: recipeCellDTO)

        return cell
    }

}
