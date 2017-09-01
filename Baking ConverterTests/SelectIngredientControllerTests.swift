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
    
    func testSelectIngredientController() {
        let model = Model()
        
        _ = SelectIngredientController(model: model)
    }
}
