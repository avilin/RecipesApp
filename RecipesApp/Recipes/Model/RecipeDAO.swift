//
//  RecipeDAO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol RecipeDAO {

    var modelFactory: ModelFactory { get }

    func configure(with recipeUpdateDelegate: RecipeUpdateDelegate)

    func findAll()

    func save(recipe: Recipe)

    func save(ingredient: Ingredient)

    func update()

    func remove(recipe: Recipe)

    func remove(ingredient: Ingredient)

}
