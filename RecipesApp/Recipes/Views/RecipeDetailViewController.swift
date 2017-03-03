//
//  RecipeDetailViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 2/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    static let cellID = "RecipeDetailViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!

    var recipe: RecipeViewData!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = recipe.image
        navigationItem.title = recipe.name
        timeLabel.text = recipe.time
    }

}

extension RecipeDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailViewController.cellID, for: indexPath)
        cell.textLabel?.text = recipe.ingredients[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients".localized()
    }
}
