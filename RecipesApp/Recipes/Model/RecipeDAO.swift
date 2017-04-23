//
//  RecipeDAO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol RecipeDAO {

    func configure(with recipeUpdateDelegate: RecipeUpdateDelegate)

    func findAll()

    func saveRecipeWith(name: String, time: Int, ingredients: [String], steps: [String], imageData: Data?)

    func update()

    func remove(recipe: Recipe)

}
