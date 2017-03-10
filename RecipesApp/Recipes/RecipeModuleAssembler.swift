//
//  RecipeSceneAssembler.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeSceneAssembler {

    lazy var recipeDAO = RecipeMockDAO()

    func assembleRecipesScene(withView recipesViewController: RecipesViewController) {
        let recipesPresenter = RecipesPresenter(recipeSceneAssembler: self, recipeDAO: recipeDAO)
        recipesViewController.recipesPresenter = recipesPresenter
    }

    func assembleRecipeDetailSceneWith(view recipeDetailViewController: RecipeDetailViewController, recipe: Recipe) {
        let recipeDetailPresenter = RecipeDetailPresenter(recipeSceneAssembler: self, recipeDAO: recipeDAO,
                                                          recipe: recipe)
        recipeDetailViewController.recipeDetailPresenter = recipeDetailPresenter
    }

    func assembleRatingSceneWith(view ratingViewController: RatingViewController, rating: Double) {
        ratingViewController.rating = rating
    }

}
