//
//  ConverterDelegate.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class ConverterController: ConverterSceneDelegate {
    
    private let ingredients = ["All-Purpose Flour",
                               "Cake Flour",
                               "Spam"]
    
    func numberOfIngredients() -> Int {
        return ingredients.count
    }
    
    func nameForIngredientAtIndex(_ index: Int) -> String? {
        switch index {
        case 0 ..< ingredients.count:
            return ingredients[index]
        default:
            return nil
        }
    }
}
