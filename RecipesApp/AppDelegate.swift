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

    // MARK: - Properties
    var window: UIWindow?
    var coreDataManager: CoreDataManager?

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initialConfiguration()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate.
        //  See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreDataManager?.saveContext()
    }

    // MARK: - Custom functions
    private func initialConfiguration() {
        coreDataManager = CoreDataManager()
        if let navigationController = window?.rootViewController as? UINavigationController,
            let recipesViewController = navigationController.visibleViewController as? RecipesViewController {
            let recipeSceneAssembler = RecipeSceneAssembler(coreDataManager: coreDataManager!)
            recipeSceneAssembler.assembleRecipesScene(withView: recipesViewController)
        }
    }

}
