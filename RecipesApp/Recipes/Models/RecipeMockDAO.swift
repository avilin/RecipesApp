//
//  RecipeMockDAO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeMockDAO: RecipeDAO {

    func findAll() -> [Recipe] {
        var recipes: [Recipe] = []

        var ingredients = ["Huevos", "Patatas", "Cebolla"]
        var image = #imageLiteral(resourceName: "placeholder_image")
        var recipe = Recipe(recipeID: 1, name: "Tortilla de patatas", time: 10, ingredients: ingredients, image: image)
        recipes.append(recipe)

        ingredients = ["Carne", "Pan de hamburguesa", "Queso", "Cebolla"]
        image = #imageLiteral(resourceName: "placeholder_image")
        recipe = Recipe(recipeID: 2, name: "Hamburguesa con queso", time: 30, ingredients: ingredients, image: image)
        recipes.append(recipe)

        return recipes
    }

}
