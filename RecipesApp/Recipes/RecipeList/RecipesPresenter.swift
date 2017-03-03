//
//  RecipesPresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipesPresenter {

    private let recipeDAO: RecipeDAO
    weak private var recipesView: RecipesView?

    var recipes: [Recipe] = []

    init(recipeDAO: RecipeDAO) {
        self.recipeDAO = recipeDAO
    }

    func attachView(recipesView: RecipesView) {
        self.recipesView = recipesView
    }

    func loadRecipes() {
        recipes = recipeDAO.findAll()
        let recipeCellViewDataList = recipes.map({ (recipe) -> RecipeCellViewData in
            return recipeCellViewDataFrom(recipe: recipe)
        })

        recipesView?.setRecipes(recipes: recipeCellViewDataList)
    }

    private func recipeCellViewDataFrom(recipe: Recipe) -> RecipeCellViewData {
        var recipeCellViewDataImage: UIImage
        if let image = recipe.image {
            recipeCellViewDataImage = image
        } else {
            recipeCellViewDataImage = #imageLiteral(resourceName: "placeholder_image")
        }

        let recipeCellViewData = RecipeCellViewData(name: recipe.name,
            time: "%d minutes".localized(arguments: recipe.time),
            ingredients: "%d ingredients".localized(arguments: recipe.ingredients.count),
            image: recipeCellViewDataImage)
        return recipeCellViewData
    }

    func recipe(at index: Int) -> RecipeViewData {
        let recipe = recipes[index]

        var recipeViewDataImage: UIImage
        if let image = recipe.image {
            recipeViewDataImage = image
        } else {
            recipeViewDataImage = #imageLiteral(resourceName: "placeholder_image")
        }

        return RecipeViewData(name: recipe.name, time: "%d minutes".localized(arguments: recipe.time),
            ingredients: recipe.ingredients, image: recipeViewDataImage)
    }

}
