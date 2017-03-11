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

    func share(data: [Any]) {
        let activityController = UIActivityViewController(
            activityItems: data, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
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

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
        let shareActionTitle = recipesPresenter.titleForCellShareAction()
        let shareAction = UITableViewRowAction(style: .default, title: shareActionTitle) { (_, indexPath) in
            self.recipesPresenter.shareData(for: indexPath)
        }
        shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)

        return [shareAction]
    }

}
