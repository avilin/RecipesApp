//
//  RecipesPresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipesPresenter {

    private let recipeWireframe: RecipeWireframe
    private let recipeDAO: RecipeDAO
    weak private var recipesView: RecipesView?

    var recipes: [Recipe] = []

    init(recipeWireframe: RecipeWireframe, recipeDAO: RecipeDAO) {
        self.recipeWireframe = recipeWireframe
        self.recipeDAO = recipeDAO
    }

    func attachView(recipesView: RecipesView) {
        self.recipesView = recipesView
    }

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

    // MARK: - Next View Configuration
    func configure(view: RecipeDetailViewController, withRecipeAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        recipeWireframe.assembleRecipeDetailModuleWith(view: view, recipe: recipe)
    }

}
