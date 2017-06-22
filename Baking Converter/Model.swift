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

struct Model {

    let ingredients: [Ingredient]
    let inputUnitsOptions: [VolumeUnit]
    let outputUnitsOptions: [MassUnit]
    
    init() {
        self.ingredients = [Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                            Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                            Ingredient(name: "Sugar", gramsPerCup: 198.0)]
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
