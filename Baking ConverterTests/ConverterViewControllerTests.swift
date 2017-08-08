//
//  ConverterViewControllerTests.swift
//  Baking Converter
//
//  Created by Michael Johnson on 8/8/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Baking_Converter

class ConverterViewControllerTests: XCTestCase {

    var SUT: ConverterViewController? = nil
    
    override func setUp() {
        super.setUp()
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        SUT = mainStoryboard.instantiateInitialViewController() as? ConverterViewController
        _ = SUT?.view
        
    }
    
    func testSetupSuccessful() {
        XCTAssertNotNil(SUT)
    }

    func testChangeIngredientButtonNotNil() {
        let button: UIButton? = SUT?.changeIngredientButton
        
        XCTAssertNotNil(button);
    }

}
