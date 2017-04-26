//
//  RecipeDetailViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 2/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import Cosmos

class RecipeDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Constants
    static let cellID = "BasicCell"

    // MARK: - Properties
    var recipeDetailPresenter: RecipeDetailPresenter!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeDetailPresenter.attachView(recipeDetailView: self)
        recipeDetailPresenter.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        recipeDetailPresenter.initView()
        tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRating", let ratingViewController = segue.destination as? RatingViewController {
            recipeDetailPresenter.configure(view: ratingViewController)
        } else if segue.identifier == "showEditRecipe",
            let editRecipeViewController = segue.destination as? EditRecipeViewController {
            recipeDetailPresenter.configure(view: editRecipeViewController)
        }
    }

    @IBAction func cancelRating(segue: UIStoryboardSegue) {
    }

    @IBAction func doneRating(segue: UIStoryboardSegue) {
        if let ratingViewController = segue.source as? RatingViewController {
            let rating = ratingViewController.rating
            recipeDetailPresenter.ratingSelected(rating)
        }
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

    func setRecipeRating(_ rating: Double) {
        ratingView.rating = rating
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
