//
//  RecipeDetailPresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class RecipeDetailPresenter {

    private let recipeDAO: RecipeDAO
    weak private var recipeDetailView: RecipeDetailView?

    private let recipe: Recipe

    init(recipeDAO: RecipeDAO, recipe: Recipe) {
        self.recipeDAO = recipeDAO
        self.recipe = recipe
    }

    func attachView(recipeDetailView: RecipeDetailView) {
        self.recipeDetailView = recipeDetailView
    }

    func initView() {
        recipeDetailView?.setRecipeName(recipe.name)
        recipeDetailView?.setRecipeTime("%d minutes".localized(arguments: recipe.time))

        if let image = recipe.image {
            recipeDetailView?.setRecipeImage(image)
        } else {
            recipeDetailView?.setPlaceholderImage()
        }
    }

    // MARK: - TableView Configuration
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(inSection section: Int) -> Int {
        return recipe.ingredients.count
    }

    func textForCell(at indexPath: IndexPath) -> String {
        let ingredient = recipe.ingredients[indexPath.row]
        return ingredient
    }

    func titleForHeader(atSection section: Int) -> String {
        return "Ingredients".localized()
    }

}
