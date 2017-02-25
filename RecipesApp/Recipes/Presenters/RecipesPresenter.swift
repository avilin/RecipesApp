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

    init(recipeDAO: RecipeDAO) {
        self.recipeDAO = recipeDAO
    }

    func attachView(recipesView: RecipesView) {
        self.recipesView = recipesView
    }

    func loadRecipes() {
        let recipes = recipeDAO.findAll()
        let recipeCellViewDataList = recipes.map({ (recipe) -> RecipeCellViewData in
            var recipeCellViewDataImage: UIImage
            if let image = recipe.image {
                recipeCellViewDataImage = image
            } else {
                recipeCellViewDataImage = #imageLiteral(resourceName: "placeholder_image")
            }

            let recipeCellViewData = RecipeCellViewData(recipeID: recipe.recipeID, name: recipe.name,
                time: "\(recipe.time) minutes", ingredients: "\(recipe.ingredients.count) ingredients",
                image: recipeCellViewDataImage)
            return recipeCellViewData
        })

        recipesView?.setRecipes(recipes: recipeCellViewDataList)
    }

}
