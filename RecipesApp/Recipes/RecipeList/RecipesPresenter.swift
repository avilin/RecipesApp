//
//  RecipesPresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipesPresenter {

    // MARK: - Properties
    private let recipeSceneAssembler: RecipeSceneAssembler
    private let recipeDAO: RecipeDAO
    weak private var recipesView: RecipesView?

    var recipes: [Recipe] = []

    // MARK: - Initialization
    init(recipeSceneAssembler: RecipeSceneAssembler, recipeDAO: RecipeDAO) {
        self.recipeSceneAssembler = recipeSceneAssembler
        self.recipeDAO = recipeDAO
    }

    func attachView(recipesView: RecipesView) {
        self.recipesView = recipesView
    }

    // MARK: - View Configuration
    func initView() {
        recipes = recipeDAO.findAll()
        recipesView?.reloadData()
    }

    // MARK: - TableView Configuration
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(inSection section: Int) -> Int {
        return recipes.count
    }

    func recipeCellDTO(for indexPath: IndexPath) -> RecipeCellDTO {
        let recipe = recipes[indexPath.row]
        let recipeCellDTO = RecipeCellDTO(name: recipe.name, time: "%d minutes".localized(arguments: recipe.time),
            ingredientsNumber: "%d ingredients".localized(arguments: recipe.ingredients.count),
            thumbnail: recipe.image)

        return recipeCellDTO
    }

    func titleForCellShareAction() -> String {
        return "Share".localized()
    }

    // MARK: - Navigation Configuration
    func configure(view: RecipeDetailViewController, withRecipeAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        recipeSceneAssembler.assembleRecipeDetailSceneWith(view: view, recipe: recipe)
    }

    // MARK: - Custom functions
    func shareData(for indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let shareText = "I like the recipe of %@".localized(arguments: recipe.name)
        let shareImage = recipe.image ?? #imageLiteral(resourceName: "placeholder_image")
        recipesView?.share(data: [shareText, shareImage])
    }

}
