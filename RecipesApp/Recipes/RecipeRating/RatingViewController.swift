//
//  RatingViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 9/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!

    // MARK: - Properties
    var rating = 0.0

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)

        ratingView.rating = rating
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ratingView.didFinishTouchingCosmos = { rating in
            self.rating = rating
        }
    }

}
