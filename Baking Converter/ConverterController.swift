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

struct VolumeUnit {
    var name: String
    var unitsPerCup: Double
}

struct MassUnit {
    var name: String
    var unitsPerGram: Double
}

class ConverterController: ConverterSceneDelegate {
    
    private var ingredients = [Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                               Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                               Ingredient(name: "Sugar", gramsPerCup: 198.0)]
    
    private var inputUnitsOptions = [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                                      VolumeUnit(name:"ml", unitsPerCup: 236.588) ]
    
//    private var outputUnitsOptions = [ "Grams", "Ounces" ]
    private var outputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1.0),
                                       MassUnit(name: "Ounces", unitsPerGram: 0.035274) ]
    
    init() {}
    
    init(ingredients: [Ingredient], inputUnitsOptions: [VolumeUnit], outputUnitsOptions: [MassUnit]) {
        self.ingredients = ingredients
        self.inputUnitsOptions = inputUnitsOptions
        self.outputUnitsOptions = outputUnitsOptions
    }
    
//    init(ingredients: [Ingredient], inputUnitsOptions: [VolumeUnit], outputUnitsOptions: [MassUnit]) {
//        
//    }
    
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
        return inputUnitsOptions[index].name
    }
    
    func numberOfOutputUnitsOptions() -> Int {
        return outputUnitsOptions.count
    }
    
    func nameForOutputUnitsOptionsAtIndex(_ index: Int) -> String? {
        guard case 0 ..< outputUnitsOptions.count = index else {
            return nil
        }
        return outputUnitsOptions[index].name
    }

    func converterSceneInputTextDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterSceneInputUnitsDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterSceneOutputUnitsDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterScene(_ scene: ConverterScene, didSelectIngredientAtIndex selectedIndex: Int) {
        updateOutputTextForScene(scene)
    }

    private func updateOutputTextForScene(_ scene: ConverterScene) {
        guard let inputText = scene.inputText,
            let quantity = Double(inputText) else {
            scene.outputText = "0"
            return
        }
        let selectedIngredient = ingredients[scene.selectedIngredientIndex]
        let selectedInputUnits = inputUnitsOptions[scene.selectedInputUnitsIndex]
        let selectedOuputUnits = outputUnitsOptions[scene.selectedOutputUnitsIndex]

        let grams = quantity * ( 1.0 / selectedInputUnits.unitsPerCup ) * selectedIngredient.gramsPerCup
//        let outputQuantity = grams
        let outputQuantity = grams * selectedOuputUnits.unitsPerGram
        scene.outputText = String(format: "%.1f", outputQuantity)
    }
    
}
