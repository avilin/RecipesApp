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
    @NSManaged var ingredients: [String]
    @NSManaged var steps: [String]
    @NSManaged var imageData: Data?
    @NSManaged var rating: Double

    func getImage() -> UIImage? {
        guard let data = imageData else {
            return nil
        }
        return UIImage(data: data)
    }

}
