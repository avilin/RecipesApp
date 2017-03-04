//
//  RecipeCellDTO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 4/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeCellDTO {

    let thumbnail: UIImage?
    let name: String
    let time: String
    let ingredientsNumber: String

    init(name: String, time: String, ingredientsNumber: String, thumbnail: UIImage?) {
        self.name = name
        self.time = time
        self.ingredientsNumber = ingredientsNumber
        self.thumbnail = thumbnail
    }

}
