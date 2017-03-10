//
//  Recipe.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class Recipe {

    var name: String
    var time: Int
    var ingredients: [String]
    var steps: [String]
    var image: UIImage?
    var rating = 0.0

    init(name: String, time: Int, ingredients: [String], steps: [String], image: UIImage?) {
        self.name = name
        self.time = time
        self.ingredients = ingredients
        self.steps = steps
        self.image = image
    }

}
