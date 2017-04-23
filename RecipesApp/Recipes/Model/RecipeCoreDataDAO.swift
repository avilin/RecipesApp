//
//  RecipeCoreDataDAO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 10/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import CoreData

class RecipeCoreDataDAO: NSObject {

    let coreDataManager: CoreDataManager
    var fetchResultsController: NSFetchedResultsController<Recipe>!
    weak var recipeUpdateDelegate: RecipeUpdateDelegate?

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

}

extension RecipeCoreDataDAO: RecipeDAO {

    func configure(with recipeUpdateDelegate: RecipeUpdateDelegate) {
        self.recipeUpdateDelegate = recipeUpdateDelegate
    }

    func findAll() {
        var recipes: [Recipe] = []
        let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let context = coreDataManager.persistentContainer.viewContext
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                managedObjectContext: context, sectionNameKeyPath: nil,
                                                                cacheName: nil)
        fetchResultsController.delegate = self
        do {
            try fetchResultsController.performFetch()
            recipes = fetchResultsController.fetchedObjects!
        } catch {
            print("Error \(error)")
        }

        recipeUpdateDelegate?.assign(recipes: recipes)
    }

    func saveRecipeWith(name: String, time: Int, ingredients: [String], steps: [String], imageData: Data?) {
        let context = coreDataManager.persistentContainer.viewContext
        guard let insertedRecipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context)
            as? Recipe else {
                fatalError()
        }
        insertedRecipe.name = name
        insertedRecipe.time = Int64(time)
        insertedRecipe.ingredients = ingredients
        insertedRecipe.steps = steps
        insertedRecipe.imageData = imageData

        coreDataManager.saveContext()
    }

    func update() {
        coreDataManager.saveContext()
    }

    func remove(recipe: Recipe) {
        let context = coreDataManager.persistentContainer.viewContext
        context.delete(recipe)
        coreDataManager.saveContext()
    }

}

extension RecipeCoreDataDAO: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeUpdateDelegate?.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                recipeUpdateDelegate?.insertRecipe(at: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                recipeUpdateDelegate?.reloadRecipe(at: indexPath)
            }
        case .delete:
            if let indexPath = indexPath {
                recipeUpdateDelegate?.deleteRecipe(at: indexPath)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                recipeUpdateDelegate?.moveRecipe(at: indexPath, to: newIndexPath)
            }
        }

        if let fetchedRecipes = controller.fetchedObjects as? [Recipe] {
            recipeUpdateDelegate?.assign(recipes: fetchedRecipes)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeUpdateDelegate?.endUpdates()
    }

}
