//
//  ConverterDelegate.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

struct Ingredient {
    var name: String
    var gramsPerCup: Double
}

class ConverterController: ConverterSceneDelegate {
    
    private var ingredients = [Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                               Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                               Ingredient(name: "Sugar", gramsPerCup: 198.0)]
    
    private var inputUnitsOptions = [ "Cups", "Milliliters" ]
    private var outputUnitsOptions = [ "Grams", "Ounces" ]
    
    init() {}
    
    init(ingredients: [Ingredient], inputUnitsOptions: [String], outputUnitsOptions: [String]) {
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
        return ingredients[index].name
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

    func converterSceneInputTextDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterScene(_ scene: ConverterScene, didSelectIngredientAtIndex selectedIndex: Int) {
        updateOutputTextForScene(scene)
    }

    private func updateOutputTextForScene(_ scene: ConverterScene) {
        guard let inputText = scene.inputText, let quantity = Double(inputText) else {
            scene.outputText = "0"
            return
        }
        let selectedIngredient = ingredients[scene.selectedIngredientIndex]
        let gramsPerCup = selectedIngredient.gramsPerCup
        let outputQuantity = gramsPerCup * quantity
        scene.outputText = String(outputQuantity)
    }
    
}
