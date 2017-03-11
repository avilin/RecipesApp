//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {

    // MARK: - Properties
    var recipesPresenter: RecipesPresenter!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        recipesPresenter.attachView(recipesView: self)
        recipesPresenter.initView()
    }

    // MARK: - Navigation
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

    func share(data: [Any]) {
        let activityController = UIActivityViewController(
            activityItems: data, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }

    func updateTableWithRowDeleted(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
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

        let recipeCellDTO = recipesPresenter.recipeData(for: indexPath)
        cell.configure(with: recipeCellDTO)

        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
        var rowActions: [UITableViewRowAction] = []
        let actions = recipesPresenter.cellActions(for: indexPath)
        for action in actions {
            let rowAction = UITableViewRowAction(style: .default, title: action.title, handler: { (_, indexPath) in
                action.action(indexPath)
            })
            if let backgroundColor = action.backgroundColor {
                rowAction.backgroundColor = backgroundColor
            }
            rowActions.append(rowAction)
        }

        return rowActions
    }

}
