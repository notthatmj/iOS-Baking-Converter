//
//  ModelTests.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/23/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Baking_Converter

fileprivate let grams = MassUnit(name: "Grams", unitsPerGram: 1)
fileprivate let kilograms = MassUnit(name: "Kilograms", unitsPerGram: 0.001);
fileprivate let sugar = Ingredient(name: "Sugar", gramsPerCup: 198.0)
fileprivate let ounces = MassUnit(name: "Ounces", unitsPerGram: 0.03527396195)
fileprivate let milliliters = VolumeUnit(name:"ml", unitsPerCup: 236.588)
fileprivate let cups = VolumeUnit(name: "Cups", unitsPerCup: 1)
fileprivate let testIngredients: [Ingredient] = [ Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                                      Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                                      Ingredient(name: "Sugar", gramsPerCup: 198.0),
                                      Ingredient(name: "Soylent", gramsPerCup: 321.0)]

fileprivate let testInputUnitsOptions: [BakingUnit] = [ cups,
                                                        milliliters,
                                                        grams,
                                                        ounces] // as [Any]

fileprivate let testOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1),
                               MassUnit(name: "Ounces", unitsPerGram: 0.035274)]

class ModelTests: XCTestCase {
    
    let SUT = Model.init(ingredients: testIngredients,
                         inputUnitsOptions: testInputUnitsOptions,
                         outputUnitsOptions: testOutputUnitsOptions)
    
    override func setUp() {
        super.setUp()
    }
    
    func test1GramsToOuncesConversion() {
        
        let result = SUT.convert(1, grams, of: sugar, to: ounces)
        
        let expectedResult = 0.03527;
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: 0.00001)
    }

    func test2GramsToOuncesConversion() {
        
        let result = SUT.convert(2, grams, of: sugar, to: ounces)
        
        let expectedResult = 0.07054;
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: 0.00001)
    }
    
    func test2KilogramToOuncesConversion() {
        let result = SUT.convert(2, kilograms, of: sugar, to: ounces)
        
        let expectedResult = 70.54792;
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: 0.00001)
    }

    func test3CupsToMilligramsConversion() {
        let result = SUT.convert(3, cups, of: sugar, to: milliliters)
    }
    
}
