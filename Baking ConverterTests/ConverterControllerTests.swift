//
//  ConverterControllerTests.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Baking_Converter

class ConverterControllerTests: XCTestCase {

    var SUT: ConverterController!

    let testIngredients: [String] = ["All-Purpose Flour",
                                      "Cake Flour",
                                      "Spam",
                                      "Tomato Sauce"]

    let testInputUnitsOptions = [ "Cups", "Milliliters", "Zorkmids" ]
    let testOutputUnitsOptions = [ "Grams", "Ounces", "Fizzbots"]
    
    override func setUp() {
        
        SUT = ConverterController(ingredients: testIngredients,
                                  inputUnitsOptions: testInputUnitsOptions,
                                  outputUnitsOptions: testOutputUnitsOptions )
    }
    
    func testNameForIngredientAtIndex() {
        // Run
        var ingredientNames: [String?] = []
        for index in 0 ..< SUT.numberOfIngredients() {
            ingredientNames.append(SUT.nameForIngredientAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfIngredients() {
            XCTAssertEqual(ingredientNames[index], testIngredients[index])
        }
    }

    func testNameForIngredientsAtIndexReturnsNilForOutOfBoundsIndex() {
        // Run
        let returnValue = SUT.nameForIngredientAtIndex(testIngredients.count)
        
        XCTAssertNil(returnValue)
    }

    func testNameForIngredientsAtIndexReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForIngredientAtIndex(testIngredients.count)
        
        XCTAssertNil(returnValue)
    }

    func testNumberOfInputsUnitOptions() {
        // Run
        let returnValue = SUT.numberOfInputUnitsOptions()
        
        // Assert
        XCTAssertEqual(returnValue, testInputUnitsOptions.count)
    }
    
    func testNameForInputUnitsOptionsAtIndex() {
        // Run
        var inputUnitsOptions: [String?] = []
        for index in 0 ..< SUT.numberOfInputUnitsOptions() {
            inputUnitsOptions.append(SUT.nameForInputUnitOptionAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfInputUnitsOptions() {
            XCTAssertEqual(inputUnitsOptions[index], testInputUnitsOptions[index])
        }
    }
    
    func testNameForInputUnitsOptionsAtIndexReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForInputUnitOptionAtIndex(-1)
        
        // Assert
        XCTAssertNil(returnValue)
    }
    
    func testNumberOfOutputUnitsOptions() {
        // Run
        let returnValue = SUT.numberOfOutputUnitsOptions()
        
        // Assert
        XCTAssertEqual(returnValue, testOutputUnitsOptions.count)
    }
    
    func testNameForOutputUnitsOptionsAtIndex() {
        // Run
        var outputUnitsOptions: [String?] = []
        for index in 0 ..< SUT.numberOfOutputUnitsOptions() {
            outputUnitsOptions.append(SUT.nameForOutputUnitsOptionsAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfOutputUnitsOptions() {
            XCTAssertEqual(outputUnitsOptions[index], testOutputUnitsOptions[index])
        }
    }
    
    func testNameForOutputUnitsOptionsAtIndexReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForOutputUnitsOptionsAtIndex(-1)
        
        // Assert
        XCTAssertNil(returnValue)
    }
    
    func testNameForOutputUnitsOptionsAtIndexReturnsNilForOutOfBoundsIndex() {
        // Run
        let returnValue = SUT.nameForOutputUnitsOptionsAtIndex(testOutputUnitsOptions.count)
        
        // Assert
        XCTAssertNil(returnValue)
    }
}