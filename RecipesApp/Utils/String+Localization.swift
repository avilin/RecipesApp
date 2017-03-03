//
//  String+Localization.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 26/2/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

extension String {

    func localized(arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }

}
