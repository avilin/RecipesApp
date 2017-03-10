//
//  RecipeDetailView.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

protocol RecipeDetailView: NSObjectProtocol {

    func setRecipeName(_ name: String)

    func setRecipeTime(_ time: String)

    func setRecipeImage(_ image: UIImage)

    func setPlaceholderImage()

    func setRecipeRating(_ rating: Double)

}
