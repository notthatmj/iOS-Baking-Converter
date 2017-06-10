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

    func testConverterController() {
        _ = ConverterController()
    }
    
    func testNameForIngredientAtIndex() {
        let SUT = ConverterController()
        
        for index in 0 ..< SUT.numberOfIngredients() {
            XCTAssertNotNil(SUT.nameForIngredientAtIndex(index))
            XCTAssertNotEqual(SUT.nameForIngredientAtIndex(index), "")
        }
        
        XCTAssertEqual(SUT.nameForIngredientAtIndex(SUT.numberOfIngredients()), nil)
        XCTAssertEqual(SUT.nameForIngredientAtIndex(-1), nil)

    }
}
