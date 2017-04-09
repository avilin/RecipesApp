//
//  CreateRecipeView.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 8/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

protocol CreateRecipeView: NSObjectProtocol {

    func updateTableWithRowAdded(at indexPath: IndexPath)

    func onSave()

}
