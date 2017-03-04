//
//  RecipeMockDAO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeMockDAO: RecipeDAO {

    var recipes: [Recipe] = []

    init() {
        var ingredients = ["Huevos", "Patatas", "Cebolla"]
        var image: UIImage? = #imageLiteral(resourceName: "placeholder_image")
        var recipe = Recipe(name: "Tortilla de patatas", time: 10, ingredients: ingredients, image: image)
        recipes.append(recipe)

        ingredients = ["Carne", "Pan de hamburguesa", "Queso", "Cebolla"]
        image = nil
        recipe = Recipe(name: "Hamburguesa con queso", time: 30, ingredients: ingredients, image: image)
        recipes.append(recipe)
    }

    func findAll() -> [Recipe] {
        return recipes
    }

}
