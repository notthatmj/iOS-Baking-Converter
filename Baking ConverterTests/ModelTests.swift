//
//  ModelTests.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/23/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Baking_Converter

fileprivate let testIngredients: [Ingredient] = [ Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                                      Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                                      Ingredient(name: "Sugar", gramsPerCup: 198.0),
                                      Ingredient(name: "Soylent", gramsPerCup: 321.0)]

fileprivate let testInputUnitsOptions = [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                                          VolumeUnit(name:"ml", unitsPerCup: 236.588),
                                          MassUnit(name: "Grams", unitsPerGram: 1),
                                          MassUnit(name: "Ounces", unitsPerGram: 0.035274)] as [Any]

fileprivate let testOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1),
                               MassUnit(name: "Ounces", unitsPerGram: 0.035274)]

class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGramsToOuncesConversion() {
        let SUT = Model.init(ingredients: testIngredients,
                             inputUnitsOptions: testInputUnitsOptions,
                             outputUnitsOptions: testOutputUnitsOptions)
    }

}
