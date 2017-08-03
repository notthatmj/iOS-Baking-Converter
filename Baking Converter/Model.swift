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

protocol BakingUnit {
    var name: String { get }
    func convert(_ quantity: Double,
                 of ingredient: Ingredient, to outUnit: BakingUnit) -> Double
    func convert(_ cups: Double, cupsOf: Ingredient) -> Double
}

struct VolumeUnit: BakingUnit {
    var name: String
    var unitsPerCup: Double
    
    func convert(_ cups: Double, cupsTo volumeUnit: VolumeUnit) -> Double {
        return cups * volumeUnit.unitsPerCup
    }
    
    func convert(_ cups: Double) -> Double {
        return cups * self.unitsPerCup
    }
    
    func convert(_ cups: Double, cupsOf: Ingredient) -> Double {
        return self.convert(cups)
    }
    
    func convert(_ quantity: Double,
                 of ingredient: Ingredient, to outUnit: BakingUnit) -> Double {
        let cups = quantity * ( 1.0 / unitsPerCup )
        return outUnit.convert(cups, cupsOf: ingredient)
    }

    func convert(_ quantity: Double, of ingredient: Ingredient, from massUnit: MassUnit) -> Double {
        let grams = quantity * (1 / massUnit.unitsPerGram)
        let cups = grams * (1 / ingredient.gramsPerCup)
        return cups * unitsPerCup
    }
}

struct MassUnit: BakingUnit {
    var name: String
    var unitsPerGram: Double
    
    init(name: String, unitsPerGram: Double) {
        self.init(name: name, unitsPerGram: unitsPerGram, unitsPerCup: 0);
    }

    init(name: String, unitsPerGram: Double, unitsPerCup: Double) {
        self.name = name;
        self.unitsPerGram = unitsPerGram;
    }
    
    func convert(quantity: Double, to massUnit: MassUnit) -> Double {
        let grams = quantity * (1 / unitsPerGram)
        return grams * massUnit.unitsPerGram
    }
    
    func convert(quantity: Double, of ingredient: Ingredient, from massUnit: MassUnit) -> Double {
        return massUnit.convert(quantity: quantity, to: self)
    }
    
    func convert(_ quantity: Double,
                 of ingredient: Ingredient, to outUnit: BakingUnit) -> Double {
        if let massUnit = outUnit as? MassUnit {
            return massUnit.convert(quantity: quantity, of: ingredient, from: self)
        } else if let volumeUnit = outUnit as? VolumeUnit {
            return volumeUnit.convert(quantity, of: ingredient, from: self)
        }
        return 0
    }

    func convert(_ cups: Double, cupsOf ingredient: Ingredient) -> Double {
        let grams = cups * ingredient.gramsPerCup
        return grams * self.unitsPerGram
    }

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

fileprivate let defaultOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1.0, unitsPerCup: 0),
                                              MassUnit(name: "Ounces", unitsPerGram: 0.035274, unitsPerCup: 0) ]

class Model {

    let ingredients: [Ingredient]
    let inputUnitsOptions: [BakingUnit]
    let outputUnitsOptions: [MassUnit]
    
    convenience init() {
        self.init(ingredients: defaultIngredients,
                  inputUnitsOptions: [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                                       VolumeUnit(name:"ml", unitsPerCup: 236.588) ],
                  outputUnitsOptions: [ MassUnit(name: "Grams", unitsPerGram: 1.0),
                                        MassUnit(name: "Ounces", unitsPerGram: 0.035274) ]);
    }
    
    init(ingredients: [Ingredient],
         inputUnitsOptions: [BakingUnit],
         outputUnitsOptions: [MassUnit]) {
        self.ingredients = ingredients
        self.inputUnitsOptions = inputUnitsOptions
        self.outputUnitsOptions = outputUnitsOptions
    }
    
    func convert(_ quantity: Double, _ inUnit: BakingUnit,
                 of ingredient: Ingredient, to outUnit: BakingUnit) -> Double {
        return inUnit.convert(quantity, of: ingredient, to: outUnit)
    }
}
