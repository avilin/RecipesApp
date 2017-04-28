//
//  ModelFactory.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 29/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import CoreData

class ModelFactory {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func makeRecipe(name: String, time: Int64, ingredients: [Ingredient], steps: [String], imageData: Data?) -> Recipe {
        let recipe = Recipe(name: name, time: time, ingredients: ingredients, steps: steps, imageData: imageData,
                            context: context)
        return recipe
    }

    func makeIngredient(name: String) -> Ingredient {
        let ingredient = Ingredient(name: name, context: context)
        return ingredient
    }

}
