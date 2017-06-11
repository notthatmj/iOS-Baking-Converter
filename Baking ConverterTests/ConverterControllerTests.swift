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

    let testInputUnitOptions = [ "Cups", "Milliliters", "Zorkmids" ]
    
    
    override func setUp() {
        
        SUT = ConverterController(ingredients: testIngredients,
                                  inputUnitsOptions: testInputUnitOptions)
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

    func testNumberOfInputUnitOptions() {
        // Run
        let returnValue = SUT.numberOfInputUnitsOptions()
        
        // Assert
        XCTAssertEqual(returnValue, testInputUnitOptions.count)
    }
    
    func testNameForInputUnitsOptionsAtIndex() {
        // Run
        var inputUnitsOptions: [String?] = []
        for index in 0 ..< SUT.numberOfInputUnitsOptions() {
            inputUnitsOptions.append(SUT.nameForInputUnitOptionAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfInputUnitsOptions() {
            XCTAssertEqual(inputUnitsOptions[index], testInputUnitOptions[index])
        }
    }
    
    func testNameForInputUnitsOptionsAtIndexReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForInputUnitOptionAtIndex(-1)
        
        // Assert
        XCTAssertNil(returnValue)
    }
}
