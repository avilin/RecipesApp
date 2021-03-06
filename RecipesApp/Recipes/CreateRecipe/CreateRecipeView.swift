//
//  CreateRecipeView.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 8/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

protocol CreateRecipeView: NSObjectProtocol {

    func insertRow(at indexPath: IndexPath)

    func deleteRow(at indexPath: IndexPath)

    func onSave()

}
