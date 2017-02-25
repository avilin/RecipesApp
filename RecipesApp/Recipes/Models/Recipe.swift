//
//  Recipe.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class Recipe {

    var recipeID: Int
    var name: String
    var time: Int
    var ingredients: [String]
    var image: UIImage?

    init(recipeID: Int, name: String, time: Int, ingredients: [String], image: UIImage?) {
        self.recipeID = recipeID
        self.name = name
        self.time = time
        self.ingredients = ingredients
        self.image = image
    }

}
