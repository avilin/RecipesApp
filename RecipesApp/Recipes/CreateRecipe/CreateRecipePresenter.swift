//
//  CreateRecipePresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 18/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class CreateRecipePresenter {

    // MARK: - Properties
    private let recipeDAO: RecipeDAO
    weak private var createRecipeView: CreateRecipeView?

    var ingredients: [Ingredient] = []
    var steps: [String] = []

    // MARK: - Initialization
    init(recipeDAO: RecipeDAO) {
        self.recipeDAO = recipeDAO
    }

    func attachView(createRecipeView: CreateRecipeView) {
        self.createRecipeView = createRecipeView
    }

    // MARK: - TableView Configuration
    func numberOfSections() -> Int {
        return 2
    }

    func numberOfRows(inSection section: Int) -> Int {
        var numberOfRows = 0
        switch section {
        case 0:
            numberOfRows = ingredients.count
        case 1:
            numberOfRows = steps.count
        default:
            break
        }
        return numberOfRows
    }

    func textForCell(at indexPath: IndexPath) -> String {
        var text = ""
        switch indexPath.section {
        case 0:
            text = ingredients[indexPath.row].name
        case 1:
            text = steps[indexPath.row]
        default:
            break
        }
        return text
    }

    func titleForHeader(atSection section: Int) -> String {
        var title = ""
        switch section {
        case 0:
            title = "Ingredients".localized()
        case 1:
            title = "Steps".localized()
        default:
            break
        }
        return title
    }

    // MARK: - Custom functions
    func validateRecipe(name: String, time: String) -> Bool {
        return Int(time) != nil
    }

    func addIngredient(_ ingredientName: String) {
        if !ingredientName.isEmpty {
            let ingredient = recipeDAO.modelFactory.makeIngredient(name: ingredientName)
            ingredients.append(ingredient)
            let indexPath = IndexPath(row: ingredients.count - 1, section: 0)
            createRecipeView?.insertRow(at: indexPath)
        }
    }

    func addStep(_ step: String) {
        if !step.isEmpty {
            steps.append(step)
            let indexPath = IndexPath(row: steps.count - 1, section: 1)
            createRecipeView?.insertRow(at: indexPath)
        }
    }

    func deleteElement(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if !ingredients.isEmpty {
                ingredients.remove(at: indexPath.row)
                createRecipeView?.deleteRow(at: indexPath)
            }
        case 1:
            if !steps.isEmpty {
                steps.remove(at: indexPath.row)
                createRecipeView?.deleteRow(at: indexPath)
            }
        default:
            break
        }
    }

    func saveRecipe(name: String, time: String, image: UIImage?) {
        var imageData: Data? = nil
        if let image = image {
            imageData = UIImagePNGRepresentation(image)
        }

        for ingredient in ingredients {
            recipeDAO.save(ingredient: ingredient)
        }

        let recipe = recipeDAO.modelFactory.makeRecipe(name: name, time: Int64(time) ?? 0, ingredients: ingredients,
                                                       steps: steps, imageData: imageData)
        recipeDAO.save(recipe: recipe)
        createRecipeView?.onSave()
    }

}
