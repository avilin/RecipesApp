//
//  RecipeViewCell.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientsNumberLabel: UILabel!

    static let cellID = "RecipeViewCell"

    func configure(with recipeCellDTO: RecipeCellDTO) {
        nameLabel.text = recipeCellDTO.name
        timeLabel.text = recipeCellDTO.time
        ingredientsNumberLabel.text = recipeCellDTO.ingredientsNumber

        if let thumbnail = recipeCellDTO.thumbnail {
            thumbnailImageView.image = thumbnail
            thumbnailImageView.contentMode = .scaleAspectFill
        } else {
            thumbnailImageView.image = #imageLiteral(resourceName: "placeholder_image")
            thumbnailImageView.contentMode = .scaleAspectFit
        }
    }

}
