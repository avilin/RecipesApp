//
//  CreateRecipePresenter.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 18/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class EditRecipePresenter {

    // MARK: - Properties
    private let recipeDAO: RecipeDAO
    private let recipe: Recipe
    weak private var editRecipeView: EditRecipeView?

    var ingredients: [Ingredient] = []
    var steps: [String] = []

    // MARK: - Initialization
    init(recipeDAO: RecipeDAO, recipe: Recipe) {
        self.recipeDAO = recipeDAO
        self.recipe = recipe
    }

    func attachView(editRecipeView: EditRecipeView) {
        self.editRecipeView = editRecipeView
    }

    func initView() {
        ingredients = recipe.ingredientsArray()
        steps = recipe.steps

        editRecipeView?.setRecipeName(recipe.name)
        editRecipeView?.setRecipeTime(String(recipe.time))

        if let image = recipe.getImage() {
            editRecipeView?.setRecipeImage(image)
        } else {
            editRecipeView?.setPlaceholderImage()
        }
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
            editRecipeView?.insertRow(at: indexPath)
        }
    }

    func addStep(_ step: String) {
        if !step.isEmpty {
            steps.append(step)
            let indexPath = IndexPath(row: steps.count - 1, section: 1)
            editRecipeView?.insertRow(at: indexPath)
        }
    }

    func deleteElement(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if !ingredients.isEmpty {
                ingredients.remove(at: indexPath.row)
                editRecipeView?.deleteRow(at: indexPath)
            }
        case 1:
            if !steps.isEmpty {
                steps.remove(at: indexPath.row)
                editRecipeView?.deleteRow(at: indexPath)
            }
        default:
            break
        }
    }

    func updateRecipe(name: String, time: String, image: UIImage?) {
        var imageData: Data? = nil
        if let image = image {
            imageData = UIImagePNGRepresentation(image)
        }

        for ingredient in ingredients {
            recipeDAO.save(ingredient: ingredient)
        }

        if let ingredientsArray = recipe.ingredients.array as? [Ingredient] {
            for ingredient in ingredientsArray {
                if !ingredients.contains(ingredient) {
                    recipeDAO.remove(ingredient: ingredient)
                }
            }
        }

        recipe.name = name
        recipe.time = Int64(time) ?? recipe.time
        recipe.ingredients = NSOrderedSet(array: ingredients)
        recipe.steps = steps
        recipe.imageData = imageData ?? recipe.imageData

        recipeDAO.update()
        editRecipeView?.onSave()
    }

}
