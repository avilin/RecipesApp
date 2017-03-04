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
        var steps = ["Pelar y cortar la cebolla", "Pelar y cortar las patatas", "Sofreír las patatas y la cebolla",
                     "Batir los huevos", "Echar los huevos batidos a la sartén con las patatas",
                     "Dar la vuelta a la tortilla cuando esté consistente por abajo", "Esperar a que se termine"]
        var image: UIImage? = #imageLiteral(resourceName: "placeholder_image")
        var recipe = Recipe(name: "Tortilla de patatas", time: 10, ingredients: ingredients, steps: steps, image: image)
        recipes.append(recipe)

        ingredients = ["Carne", "Pan de hamburguesa", "Queso", "Cebolla"]
        steps = ["Pelar y cortar la cebolla", "Sofreír la cebolla", "Hacer la carne al gusto",
                 "Montar la carne, el queso y la cebolla en el pan"]
        image = nil
        recipe = Recipe(name: "Hamburguesa con queso", time: 30, ingredients: ingredients, steps: steps, image: image)
        recipes.append(recipe)
    }

    func findAll() -> [Recipe] {
        return recipes
    }

}
