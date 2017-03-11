//
//  RecipeCellActionDTO.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 11/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeCellActionDTO {

    let title: String
    let backgroundColor: UIColor?
    let action: (IndexPath) -> Void

    init(title: String, backgroundColor: UIColor?, action: @escaping (IndexPath) -> Void) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.action = action
    }

}
