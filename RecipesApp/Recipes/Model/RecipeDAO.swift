//
//  RecipeDAO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

protocol RecipeDAO {

    func findAll() -> [Recipe]

    func save(recipe: Recipe)

    func remove(recipe: Recipe)

}
