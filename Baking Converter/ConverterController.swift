//
//  ConverterDelegate.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class ConverterController: ConverterSceneDelegate {
    
    private var ingredients = ["All-Purpose Flour",
                               "Cake Flour",
                               "Sugar"]

    private var inputUnitsOptions = [ "Cups", "Milliliters" ]
    
    init() {}
    
    init(ingredients: [String], inputUnitsOptions: [String]) {
        self.ingredients = ingredients
        self.inputUnitsOptions = inputUnitsOptions
    }
    
    func numberOfIngredients() -> Int {
        return ingredients.count
    }
    
    func nameForIngredientAtIndex(_ index: Int) -> String? {
        guard case 0 ..< ingredients.count = index else {
            return nil
        }
        return ingredients[index]
    }
    
    func numberOfInputUnitsOptions() -> Int {
        return inputUnitsOptions.count
    }
    
    func nameForInputUnitOptionAtIndex(_ index: Int) -> String? {
        guard case 0 ..< inputUnitsOptions.count = index  else {
            return nil
        }
        return inputUnitsOptions[index]
    }
}
