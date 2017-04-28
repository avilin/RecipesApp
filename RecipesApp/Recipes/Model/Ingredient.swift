//
//  Ingredient.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 27/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import CoreData

class Ingredient: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var checked: Bool

    convenience init(name: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: context)
        self.init(entity: entity!, insertInto: nil)

        self.name = name
    }

}
