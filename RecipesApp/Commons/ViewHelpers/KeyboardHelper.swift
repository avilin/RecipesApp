//
//  KeyboardHelper.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 9/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class KeyboardHelper: NSObject {

    weak private var viewController: UIViewController?

    func configure(viewController: UIViewController) {
        self.viewController = viewController
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(dismissKeyboard))
        viewController.view.addGestureRecognizer(tapGestureRecognizer)
    }

    func dismissKeyboard() {
        viewController?.view.endEditing(true)
    }
}
