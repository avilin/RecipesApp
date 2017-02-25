//
//  AppDelegate.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 18/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureRecipesModule()

        return true
    }

    private func configureRecipesModule() {
        guard let navigationController = window?.rootViewController as? UINavigationController else {
            print("There was an error loading the rootViewController")
            fatalError()
        }
        guard let recipesViewController = navigationController.visibleViewController as? RecipesViewController else {
            print("There was an error loading the visibleViewController")
            fatalError()
        }
        let recipeDAO = RecipeMockDAO()
        let recipesPresenter = RecipesPresenter(recipeDAO: recipeDAO)
        recipesViewController.recipesPresenter = recipesPresenter
    }

}
