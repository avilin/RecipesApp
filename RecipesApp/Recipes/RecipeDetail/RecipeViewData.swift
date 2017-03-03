//
//  RecipeViewData.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 3/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeViewData: NSObject {

    var name: String
    var time: String
    var ingredients: [String]
    var image: UIImage?

    init(name: String, time: String, ingredients: [String], image: UIImage) {
        self.name = name
        self.time = time
        self.ingredients = ingredients
        self.image = image
    }

}
