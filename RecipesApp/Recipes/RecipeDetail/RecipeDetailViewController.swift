//
//  RecipeDetailViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 2/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!

    static let cellID = "RecipeDetailViewCell"

    var recipeDetailPresenter: RecipeDetailPresenter!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeDetailPresenter.attachView(recipeDetailView: self)
        recipeDetailPresenter.initView()
    }

}

// MARK: - RecipeDetailView
extension RecipeDetailViewController: RecipeDetailView {

    func setRecipeName(_ name: String) {
        navigationItem.title = name
    }

    func setRecipeTime(_ time: String) {
        timeLabel.text = time
    }

    func setRecipeImage(_ image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
    }

    func setPlaceholderImage() {
        imageView.image = #imageLiteral(resourceName: "placeholder_image")
        imageView.contentMode = .scaleAspectFit
    }

}

// MARK: - UITableViewDataSource
extension RecipeDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return recipeDetailPresenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetailPresenter.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailViewController.cellID, for: indexPath)
        cell.textLabel?.text = recipeDetailPresenter.textForCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipeDetailPresenter.titleForHeader(atSection: section)
    }
}
