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
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, to outUnit: BakingUnit) -> Double
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, from volumeUnit: VolumeUnit) -> Double
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, from massUnit: MassUnit) -> Double
}

struct VolumeUnit {

    var name: String

    var unitsPerCup: Double
    
    func convert(quantity: Double, to volumeUnit: VolumeUnit) -> Double {
        let cups = quantity * (1 / unitsPerCup)
        return cups * volumeUnit.unitsPerCup
    }

}

extension VolumeUnit: BakingUnit {

    func convertQuantity(_ quantity: Double,
                         of ingredient: Ingredient,
                         to outUnit: BakingUnit) -> Double {
        return outUnit.convertQuantity(quantity, of: ingredient, from: self)
    }
    
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, from volumeUnit: VolumeUnit) -> Double {
        return volumeUnit.convert(quantity: quantity, to: self)
    }
    
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, from massUnit: MassUnit) -> Double {
        let grams = quantity * (1 / massUnit.unitsPerGram)
        let cups = grams * (1 / ingredient.gramsPerCup)
        return cups * unitsPerCup
    }
    
}

struct MassUnit {
    var name: String
    
    var unitsPerGram: Double
    
    func convert(quantity: Double, to massUnit: MassUnit) -> Double {
        let grams = quantity * (1 / unitsPerGram)
        return grams * massUnit.unitsPerGram
    }
    
}

extension MassUnit: BakingUnit {
    func convertQuantity(_ quantity: Double,
                         of ingredient: Ingredient,
                         to outUnit: BakingUnit) -> Double {
        return outUnit.convertQuantity(quantity, of: ingredient, from: self)
    }
    
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, from fromUnit: VolumeUnit) -> Double {
        let cups = quantity * (1 / fromUnit.unitsPerCup)
        let grams = cups * ingredient.gramsPerCup
        return grams * unitsPerGram
    }
    
    func convertQuantity(_ quantity: Double, of ingredient: Ingredient, from fromUnit: MassUnit) -> Double {
        return fromUnit.convert(quantity: quantity, to: self)
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

fileprivate let defaultOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1.0),
                                              MassUnit(name: "Ounces", unitsPerGram: 0.035274) ]

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
        return inUnit.convertQuantity(quantity, of: ingredient, to: outUnit)
    }
}
