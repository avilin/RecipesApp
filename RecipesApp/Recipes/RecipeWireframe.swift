//
//  RecipeWireframe.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeWireframe {

    lazy var recipeDAO = RecipeMockDAO()

    func assembleRecipesModuleWith(view recipesViewController: RecipesViewController) {
        let recipesPresenter = RecipesPresenter(recipeWireframe: self, recipeDAO: recipeDAO)
        recipesViewController.recipesPresenter = recipesPresenter
    }

    func assembleRecipeDetailModuleWith(view recipeDetailViewController: RecipeDetailViewController, recipe: Recipe) {
        let recipeDetailPresenter = RecipeDetailPresenter(recipeDAO: recipeDAO, recipe: recipe)
        recipeDetailViewController.recipeDetailPresenter = recipeDetailPresenter
    }

}
