//
//  RecipeSceneAssembler.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeSceneAssembler {

    private let recipeDAO: RecipeDAO

    init(coreDataManager: CoreDataManager) {
        recipeDAO = RecipeCoreDataDAO(coreDataManager: coreDataManager)
    }

    func assembleRecipesScene(withView recipesViewController: RecipesViewController) {
        let recipesPresenter = RecipesPresenter(recipeSceneAssembler: self, recipeDAO: recipeDAO)
        recipesViewController.recipesPresenter = recipesPresenter
        recipeDAO.configure(with: recipesPresenter)
    }

    func assembleRecipeDetailSceneWith(view recipeDetailViewController: RecipeDetailViewController, recipe: Recipe) {
        let recipeDetailPresenter = RecipeDetailPresenter(recipeSceneAssembler: self, recipeDAO: recipeDAO,
                                                          recipe: recipe)
        recipeDetailViewController.recipeDetailPresenter = recipeDetailPresenter
    }

    func assembleRatingSceneWith(view ratingViewController: RatingViewController, rating: Double) {
        ratingViewController.rating = rating
    }

    func assembleCreateRecipeScene(withView createRecipeViewController: CreateRecipeViewController) {
        let createRecipePresenter = CreateRecipePresenter(recipeDAO: recipeDAO)
        createRecipeViewController.createRecipePresenter = createRecipePresenter
    }

    func assembleEditRecipeSceneWith(view editRecipeViewController: EditRecipeViewController, recipe: Recipe) {
        let editRecipePresenter = EditRecipePresenter(recipeDAO: recipeDAO, recipe: recipe)
        editRecipeViewController.editRecipePresenter = editRecipePresenter
    }

}
