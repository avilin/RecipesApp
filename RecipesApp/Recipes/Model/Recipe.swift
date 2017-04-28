//
//  Recipe.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import CoreData

class Recipe: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var time: Int64
    @NSManaged var ingredients: NSOrderedSet
    @NSManaged var steps: [String]
    @NSManaged var imageData: Data?
    @NSManaged var rating: Double

    convenience init(name: String, time: Int64, ingredients: [Ingredient], steps: [String], imageData: Data?,
                     context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)
        self.init(entity: entity!, insertInto: nil)

        self.name = name
        self.time = time
        self.ingredients = NSOrderedSet(array: ingredients)
        self.steps = steps
        self.imageData = imageData
    }

    func ingredientsArray() -> [Ingredient] {
        var ingredients: [Ingredient] = []
        if let ingredientsArray = self.ingredients.array as? [Ingredient] {
            ingredients = ingredientsArray
        }
        return ingredients
    }

    func getImage() -> UIImage? {
        guard let data = imageData else {
            return nil
        }
        return UIImage(data: data)
    }

}
