//
//  SelectIngredientControllerTests.swift
//  Baking Converter
//
//  Created by Michael Johnson on 8/31/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Baking_Converter

class SelectIngredientControllerTests: XCTestCase {
    
    var model: Model!
    var SUT: SelectIngredientController!
    
    override func setUp() {
        model = Model(ingredients: testIngredients,
                      inputUnitsOptions: testInputUnitsOptions,
                      outputUnitsOptions: testOutputUnitsOptions)
        
        SUT = SelectIngredientController(model: model)
    }
    
    func testTitleForCellAtIndex_WithIndex0() {
        let result = SUT.titleForCellAtIndex(0)
        
        XCTAssertEqual(result, testIngredients[0].name)
    }

    func testTitleForCellAtIndex_WithIndex1() {
        let result = SUT.titleForCellAtIndex(1)
        
        XCTAssertEqual(result, testIngredients[1].name)
    }
    
    func testTitleForCellAtIndex_WithNegativeIndex() {
        let result = SUT.titleForCellAtIndex(-1)
        
        XCTAssertEqual(result, "")
    }
    
    func testTitleForCellAtIndex_WithOutOfBoundsIndex() {
        let result = SUT.titleForCellAtIndex(testIngredients.count)
        
        XCTAssertEqual(result, "")
    }
    
    func testNumberOfRows() {
        let result = SUT.numberOfRows()
        
        XCTAssertEqual(result, testIngredients.count)
    }

}

