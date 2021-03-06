//
//  RecipesView.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

protocol RecipesView: NSObjectProtocol {

    func reloadData()

    func share(data: [Any])

    func beginTableUpdates()

    func insertRecipe(at indexPath: IndexPath)

    func reloadRecipe(at indexPath: IndexPath)

    func deleteRecipe(at indexPath: IndexPath)

    func moveRecipe(at indexPath: IndexPath, to newIndexPath: IndexPath)

    func endTableUpdates()

}
