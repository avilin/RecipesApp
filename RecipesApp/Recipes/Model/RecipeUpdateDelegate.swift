//
//  RecipeListUpdateDelegate.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 21/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol RecipeUpdateDelegate: NSObjectProtocol {

    func beginUpdates()

    func insertRecipe(at indexPath: IndexPath)

    func reloadRecipe(at indexPath: IndexPath)

    func deleteRecipe(at indexPath: IndexPath)

    func moveRecipe(at indexPath: IndexPath, to newIndexPath: IndexPath)

    func assign(recipes: [Recipe])

    func endUpdates()

}
