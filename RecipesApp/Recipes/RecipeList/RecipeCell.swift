//
//  RecipeViewCell.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 19/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientsNumberLabel: UILabel!

    // MARK: - Constants
    static let cellID = "RecipeViewCell"

    // MARK: - Custom functions
    func configure(with recipeCellDTO: RecipeCellDTO) {
        nameLabel.text = recipeCellDTO.name
        timeLabel.text = recipeCellDTO.time
        ingredientsNumberLabel.text = recipeCellDTO.ingredientsNumber

        if let thumbnail = recipeCellDTO.thumbnail {
            thumbnailImageView.image = thumbnail
            thumbnailImageView.contentMode = .scaleAspectFill
            thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width / 2
        } else {
            thumbnailImageView.image = #imageLiteral(resourceName: "placeholder_image")
            thumbnailImageView.contentMode = .scaleAspectFit
            thumbnailImageView.layer.cornerRadius = 0
        }
    }

}
