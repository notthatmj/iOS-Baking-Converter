//
//  Model.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/22/17.
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

fileprivate let defaultIngredients = [Ingredient(name: "Baking Powder", gramsPerCup: 192.0),
                                      Ingredient(name: "Baking Soda", gramsPerCup: 288.0),
                                      Ingredient(name: "Butter", gramsPerCup: 226),
                                      Ingredient(name: "Flour, All-Purpose", gramsPerCup: 120.0),
                                      Ingredient(name: "Flour, Bread", gramsPerCup: 120.0),
                                      Ingredient(name: "Flour, Cake", gramsPerCup: 120.0),
                                      Ingredient(name: "Flour, Durum", gramsPerCup: 124.0),
                                      Ingredient(name: "Flour, Pastry", gramsPerCup: 113.0),
                                      Ingredient(name: "Sugar, Granulated White", gramsPerCup: 198.0),
                                      Ingredient(name: "Sugar, Brown (packed)", gramsPerCup: 213.0),
                                      Ingredient(name: "Whole-wheat Flour", gramsPerCup: 113.0)]

fileprivate let defaultInputUnitsOptions = [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                                             VolumeUnit(name:"ml", unitsPerCup: 236.588) ]

fileprivate let defaultOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1.0),
                                              MassUnit(name: "Ounces", unitsPerGram: 0.035274) ]

class Model {

    let ingredients: [Ingredient]
    let inputUnitsOptions: [VolumeUnit]
    let outputUnitsOptions: [MassUnit]
    
    init() {
        self.ingredients = defaultIngredients
        self.inputUnitsOptions = [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                                   VolumeUnit(name:"ml", unitsPerCup: 236.588) ]
        self.outputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1.0),
                                    MassUnit(name: "Ounces", unitsPerGram: 0.035274) ]
    }
    
    init(ingredients: [Ingredient],
         inputUnitsOptions: [VolumeUnit],
         outputUnitsOptions: [MassUnit]) {
        self.ingredients = ingredients
        self.inputUnitsOptions = inputUnitsOptions
        self.outputUnitsOptions = outputUnitsOptions
    }
    
    func convert(_ quantity: Double, _ inUnit: VolumeUnit,
                 of ingredient: Ingredient, to outUnit: MassUnit) -> Double {
        let grams = quantity * ( 1.0 / inUnit.unitsPerCup ) * ingredient.gramsPerCup
        let outputQuantity = grams * outUnit.unitsPerGram
        return outputQuantity
    }

}
