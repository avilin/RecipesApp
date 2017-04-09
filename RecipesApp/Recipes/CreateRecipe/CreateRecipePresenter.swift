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

    var name = ""
    var time = 0
    var ingredients: [String] = []
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
            text = ingredients[indexPath.row]
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
        guard let time = Int(time) else {
            return false
        }
        self.name = name
        self.time = time
        return true
    }

    func addIngredient(_ ingredient: String) {
        if !ingredient.isEmpty {
            ingredients.append(ingredient)
            let indexPath = IndexPath(row: ingredients.count - 1, section: 0)
            createRecipeView?.updateTableWithRowAdded(at: indexPath)
        }
    }

    func addStep(_ step: String) {
        if !step.isEmpty {
            steps.append(step)
            let indexPath = IndexPath(row: steps.count - 1, section: 1)
            createRecipeView?.updateTableWithRowAdded(at: indexPath)
        }
    }

    func saveRecipe() {
        let recipe = Recipe(name: name, time: time, ingredients: ingredients, steps: steps, image: #imageLiteral(resourceName: "placeholder_image"))
        recipeDAO.save(recipe: recipe)
        createRecipeView?.onSave()
    }

}
