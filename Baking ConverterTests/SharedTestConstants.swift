//
//  SharedTestCode.swift
//  Baking Converter
//
//  Created by Michael Johnson on 9/2/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation
@testable import Baking_Converter

let testIngredients: [Ingredient] = [ Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                                      Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                                      Ingredient(name: "Sugar", gramsPerCup: 198.0),
                                      Ingredient(name: "Soylent", gramsPerCup: 321.0)]

let testInputUnitsOptions = [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                              VolumeUnit(name:"ml", unitsPerCup: 236.588) ]

let testOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1),
                               MassUnit(name: "Ounces", unitsPerGram: 0.035274)]
