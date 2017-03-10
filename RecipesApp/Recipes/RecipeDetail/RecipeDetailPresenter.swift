//
//  RecipeDetailPresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class RecipeDetailPresenter {

    // MARK: - Properties
    private let recipeSceneAssembler: RecipeSceneAssembler
    private let recipeDAO: RecipeDAO
    weak private var recipeDetailView: RecipeDetailView?

    private let recipe: Recipe

    // MARK: - Initialization
    init(recipeSceneAssembler: RecipeSceneAssembler, recipeDAO: RecipeDAO, recipe: Recipe) {
        self.recipeSceneAssembler = recipeSceneAssembler
        self.recipeDAO = recipeDAO
        self.recipe = recipe
    }

    func attachView(recipeDetailView: RecipeDetailView) {
        self.recipeDetailView = recipeDetailView
    }

    // MARK: - View Configuration
    func initView() {
        recipeDetailView?.setRecipeName(recipe.name)
        recipeDetailView?.setRecipeTime("%d minutes".localized(arguments: recipe.time))

        if let image = recipe.image {
            recipeDetailView?.setRecipeImage(image)
        } else {
            recipeDetailView?.setPlaceholderImage()
        }

        recipeDetailView?.setRecipeRating(recipe.rating)
    }

    func ratingSelected(_ rating: Double) {
        recipe.rating = rating
        recipeDetailView?.setRecipeRating(rating)
    }

    // MARK: - TableView Configuration
    func numberOfSections() -> Int {
        return 2
    }

    func numberOfRows(inSection section: Int) -> Int {
        var numberOfRows = 0
        switch section {
        case 0:
            numberOfRows = recipe.ingredients.count
        case 1:
            numberOfRows = recipe.steps.count
        default:
            break
        }
        return numberOfRows
    }

    func textForCell(at indexPath: IndexPath) -> String {
        var text = ""
        switch indexPath.section {
        case 0:
            text = recipe.ingredients[indexPath.row]
        case 1:
            text = recipe.steps[indexPath.row]
        default:
            break
        }
        return text
    }

    func titleForHeader(atSection section: Int) -> String {
        var title = ""
        switch section {
        case 0:
            title = "Ingredients".localized()
        case 1:
            title = "Steps".localized()
        default:
            break
        }
        return title
    }

    // MARK: - Navigation Configuration
    func configure(view: RatingViewController) {
        let rating = recipe.rating
        recipeSceneAssembler.assembleRatingSceneWith(view: view, rating: rating)
    }

}
