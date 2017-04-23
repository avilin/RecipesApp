//
//  RecipesPresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipesPresenter: NSObject {

    // MARK: - Properties
    private let recipeSceneAssembler: RecipeSceneAssembler
    private let recipeDAO: RecipeDAO
    weak fileprivate var recipesView: RecipesView?

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
        recipeDAO.findAll()
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
            thumbnail: recipe.getImage())

        return recipeCellDTO
    }

    func cellActions(for indexPath: IndexPath) -> [CellActionDTO] {
        let shareTitle = "Share".localized()
        let shareBackgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        let shareAction = CellActionDTO(title: shareTitle, backgroundColor: shareBackgroundColor) { (indexPath) in
            self.shareData(for: indexPath)
        }

        let deleteTitle = "Delete".localized()
        let deleteAction = CellActionDTO(title: deleteTitle, backgroundColor: nil) { (indexPath) in
            self.removeRecipe(at: indexPath)
        }

        return [shareAction, deleteAction]
    }

    // MARK: - Navigation Configuration
    func configure(view: RecipeDetailViewController, withRecipeAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        recipeSceneAssembler.assembleRecipeDetailSceneWith(view: view, recipe: recipe)
    }

    func configure(view: CreateRecipeViewController) {
        recipeSceneAssembler.assembleCreateRecipeScene(withView: view)
    }

    // MARK: - Custom functions
    func shareData(for indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let shareText = "I like the recipe of %@".localized(arguments: recipe.name)
        let shareImage = recipe.getImage() ?? #imageLiteral(resourceName: "placeholder_image")
        recipesView?.share(data: [shareText, shareImage])
    }

    func removeRecipe(at indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        recipeDAO.remove(recipe: recipe)
    }

}

// MARK: - RecipeUpdateDelegate
extension RecipesPresenter: RecipeUpdateDelegate {

    func beginUpdates() {
        recipesView?.beginTableUpdates()
    }

    func insertRecipe(at indexPath: IndexPath) {
        recipesView?.insertRecipe(at: indexPath)
    }

    func reloadRecipe(at indexPath: IndexPath) {
        recipesView?.reloadRecipe(at: indexPath)
    }

    func deleteRecipe(at indexPath: IndexPath) {
        recipesView?.deleteRecipe(at: indexPath)
    }

    func moveRecipe(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        recipesView?.moveRecipe(at: indexPath, to: newIndexPath)
    }

    func assign(recipes: [Recipe]) {
        self.recipes = recipes
        recipesView?.reloadData()
    }

    func endUpdates() {
        recipesView?.endTableUpdates()
    }

}
