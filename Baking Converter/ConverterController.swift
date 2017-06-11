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
    private var outputUnitsOptions = [ "Grams", "Ounces" ]
    
    init() {}
    
    init(ingredients: [String], inputUnitsOptions: [String], outputUnitsOptions: [String]) {
        self.ingredients = ingredients
        self.inputUnitsOptions = inputUnitsOptions
        self.outputUnitsOptions = outputUnitsOptions
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
    
    func numberOfOutputUnitsOptions() -> Int {
        return outputUnitsOptions.count
    }
    
    func nameForOutputUnitsOptionsAtIndex(_ index: Int) -> String? {
        guard case 0 ..< outputUnitsOptions.count = index else {
            return nil
        }
        return outputUnitsOptions[index]
    }
    
}
