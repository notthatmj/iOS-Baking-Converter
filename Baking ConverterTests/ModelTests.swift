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
fileprivate let ounces = MassUnit(name: "Ounces", unitsPerGram: 0.035273962)
fileprivate let cups = VolumeUnit(name: "Cups", unitsPerCup: 1)
fileprivate let milliliters = VolumeUnit(name:"ml", unitsPerCup: 236.58824)
fileprivate let sugar = Ingredient(name: "Sugar", gramsPerCup: 198.0)

class ModelTests: XCTestCase {
    
    let SUT = Model()
    let expectedAccuracy = 0.00001
    
    func test1GramsToOuncesConversion() {
        
        let result = SUT.convert(1, grams, of: sugar, to: ounces)
        
        let expectedResult = 0.03527;
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: expectedAccuracy)
    }

    func test2GramsToOuncesConversion() {
        
        let result = SUT.convert(2, grams, of: sugar, to: ounces)
        
        let expectedResult = 0.07054;
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: expectedAccuracy)
    }
    
    func test2KilogramToOuncesConversion() {
        let result = SUT.convert(2, kilograms, of: sugar, to: ounces)
        
        let expectedResult = 70.54792
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: expectedAccuracy)
    }

    func test3CupsToMillilitersConversion() {
        let result = SUT.convert(3, cups, of: sugar, to: milliliters)
        
        let expectedResult = 709.76472
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: expectedAccuracy)
    }
    
    func test3OuncesOfSugarToMillilitersConversion() {
        let result = SUT.convert(3, ounces, of: sugar, to: milliliters)
        
        let expectedResult = 101.62370
        XCTAssertEqualWithAccuracy(result, expectedResult, accuracy: expectedAccuracy)
    }
}
