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

    func recipeData(for indexPath: IndexPath) -> RecipeCellDTO {
        let recipe = recipes[indexPath.row]
        let recipeCellDTO = RecipeCellDTO(name: recipe.name, time: "%d minutes".localized(arguments: recipe.time),
            ingredientsNumber: "%d ingredients".localized(arguments: recipe.ingredients.count),
            thumbnail: recipe.image)

        return recipeCellDTO
    }

    func cellActions(for indexPath: IndexPath) -> [RecipeCellActionDTO] {
        let shareTitle = "Share".localized()
        let shareBackgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        let shareAction = RecipeCellActionDTO(title: shareTitle, backgroundColor: shareBackgroundColor) { (indexPath) in
            self.shareData(for: indexPath)
        }

        let deleteTitle = "Delete".localized()
        let deleteAction = RecipeCellActionDTO(title: deleteTitle, backgroundColor: nil) { (indexPath) in
            self.removeRecipe(at: indexPath)
        }

        return [shareAction, deleteAction]
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

    func removeRecipe(at indexPath: IndexPath) {
        recipes.remove(at: indexPath.row)
        recipesView?.updateTableWithRowDeleted(at: indexPath)
    }

}
