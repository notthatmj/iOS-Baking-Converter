//
//  ConverterControllerTests.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import XCTest
@testable import Baking_Converter

class FakeConverterScene: ConverterScene {
    var inputText: String? = nil
    var outputText: String? = nil
    var selectedIngredientIndex: Int = 0
    var selectedInputUnitsIndex: Int = 0
    var selectedOutputUnitsIndex: Int = 0
    func converterScene(_ : ConverterScene, didSelectIngredientAtIndex: Int) { }
}

class FakeSelectIngredientScene: SelectIngredientScene {
    var model: Model! = nil
    var controller: SelectIngredientController! = nil
}

fileprivate let testIngredients: [Ingredient] = [ Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                                                  Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                                                  Ingredient(name: "Sugar", gramsPerCup: 198.0),
                                                  Ingredient(name: "Soylent", gramsPerCup: 321.0)]

fileprivate let testInputUnitsOptions = [ VolumeUnit(name: "Cups", unitsPerCup: 1),
                                          VolumeUnit(name:"ml", unitsPerCup: 236.588) ]

fileprivate let testOutputUnitsOptions = [ MassUnit(name: "Grams", unitsPerGram: 1),
                                           MassUnit(name: "Ounces", unitsPerGram: 0.035274)]

class ConverterControllerTests: XCTestCase {

    var SUT: ConverterController!
    
    override func setUp() {
        SUT = ConverterController(ingredients: testIngredients,
                                  inputUnitsOptions: testInputUnitsOptions,
                                  outputUnitsOptions: testOutputUnitsOptions )
    }
    
    func testNameForIngredientAtIndex() {
        // Run
        var ingredientNames: [String?] = []
        for index in 0 ..< SUT.numberOfIngredients {
            ingredientNames.append(SUT.nameForIngredientAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfIngredients {
            XCTAssertEqual(ingredientNames[index], testIngredients[index].name)
        }
    }

    func testNameForIngredientsAtIndex_ReturnsNilForOutOfBoundsIndex() {
        // Run
        let returnValue = SUT.nameForIngredientAtIndex(testIngredients.count)
        
        XCTAssertNil(returnValue)
    }

    func testNameForIngredientsAtIndex_ReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForIngredientAtIndex(testIngredients.count)
        
        XCTAssertNil(returnValue)
    }

    func testNumberOfInputUnitsOptions() {
        // Run
        let returnValue = SUT.numberOfInputUnitsOptions
        
        // Assert
        XCTAssertEqual(returnValue, testInputUnitsOptions.count)
    }
    
    func testNameForInputUnitsOptionsAtIndex() {
        // Run
        var inputUnitsOptionsNames: [String?] = []
        for index in 0 ..< SUT.numberOfInputUnitsOptions {
            inputUnitsOptionsNames.append(SUT.nameForInputUnitOptionAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfInputUnitsOptions {
            XCTAssertEqual(inputUnitsOptionsNames[index], testInputUnitsOptions[index].name)
        }
    }
    
    func testNameForInputUnitsOptionsAtIndex_ReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForInputUnitOptionAtIndex(-1)
        
        // Assert
        XCTAssertNil(returnValue)
    }
    
    func testNumberOfOutputUnitsOptions() {
        // Run
        let returnValue = SUT.numberOfOutputUnitsOptions
        
        // Assert
        XCTAssertEqual(returnValue, testOutputUnitsOptions.count)
    }
    
    func testNameForOutputUnitsOptionsAtIndex() {
        // Run
        var outputUnitsOptionsNames: [String?] = []
        for index in 0 ..< SUT.numberOfOutputUnitsOptions {
            outputUnitsOptionsNames.append(SUT.nameForOutputUnitsOptionsAtIndex(index))
        }
        
        // Assert
        for index in 0 ..< SUT.numberOfOutputUnitsOptions {
            XCTAssertEqual(outputUnitsOptionsNames[index], testOutputUnitsOptions[index].name)
        }
    }
    
    func testNameForOutputUnitsOptionsAtIndex_ReturnsNilForNegativeIndex() {
        // Run
        let returnValue = SUT.nameForOutputUnitsOptionsAtIndex(-1)
        
        // Assert
        XCTAssertNil(returnValue)
    }
    
    func testNameForOutputUnitsOptionsAtIndex_ReturnsNilForOutOfBoundsIndex() {
        // Run
        let returnValue = SUT.nameForOutputUnitsOptionsAtIndex(testOutputUnitsOptions.count)
        
        // Assert
        XCTAssertNil(returnValue)
    }

    func testPrepareScene() {
        let fakeSelectIngredientScene = FakeSelectIngredientScene()

        SUT.prepareDestinationScene(fakeSelectIngredientScene)
        
        XCTAssertNotNil(fakeSelectIngredientScene.controller)
        XCTAssert(fakeSelectIngredientScene.controller.model === SUT.model)
    }
}

class ConverterController_OutputTextWasUpdated_Tests: XCTestCase {
    
    var SUT: ConverterController!
    let fakeScene = FakeConverterScene()
    
    override func setUp() {
        
        SUT = ConverterController(ingredients: testIngredients,
                                  inputUnitsOptions: testInputUnitsOptions,
                                  outputUnitsOptions: testOutputUnitsOptions )
        fakeScene.inputText = "1"
    }
    
    private func AssertThatOutputTextWasUpdated(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(fakeScene.outputText, "120.0", file: file, line: line)
    }
    
    func testConverterSceneInputTextDidChange() {
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        AssertThatOutputTextWasUpdated()
    }
    
    func testConverterSceneDidSelectIngredientAtIndex() {
        // Run
        SUT.converterSceneIngredientDidChange(fakeScene);
        
        // Assert
        AssertThatOutputTextWasUpdated()
    }
    
    func testInputUnitsDidChange() {
        // Run
        SUT.converterSceneInputUnitsDidChange(fakeScene)
        
        // Assert
        AssertThatOutputTextWasUpdated()
    }
    
    func testConverterSceneOutputUnitsDidChange() {
        // Run
        SUT.converterSceneOutputUnitsDidChange(fakeScene)
        
        // Assert
        AssertThatOutputTextWasUpdated()
    }
}

class ConverterController_Conversion_Tests: XCTestCase {
    
    var SUT: ConverterController!
    var fakeScene: FakeConverterScene!
    
    override func setUp() {
        SUT = ConverterController(ingredients: testIngredients,
                                  inputUnitsOptions: testInputUnitsOptions,
                                  outputUnitsOptions: testOutputUnitsOptions )
        fakeScene = FakeConverterScene()
    }
    
    func testConvert2CupsOfFlourToGrams() {
        // Setup
        fakeScene.inputText = "2"
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "240.0")
    }
    
    func testConvert1CupOfSugarToGrams() {
        // Setup
        fakeScene.inputText = "1"
        fakeScene.selectedIngredientIndex = 2
        
        // Run
        SUT.converterSceneIngredientDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "198.0")
    }
    
    func testConvert3CupsOfSugarToGrams() {
        // Setup
        fakeScene.inputText = "3"
        fakeScene.selectedIngredientIndex = 2
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "594.0")
    }

    func testConvertBadInputText() {
        // Setup
        fakeScene.inputText = "2.."
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "0")
    }
    
    func testConvert650mlCakeFlourToGrams() {
        // Setup
        fakeScene.inputText = "650"
        fakeScene.selectedInputUnitsIndex = 1
        
        // Run
        SUT.converterSceneInputUnitsDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "329.7")
    }
    
    func test_Convert650mlCakeFlourToOunces() {
        // Setup
        fakeScene.inputText = "650"
        fakeScene.selectedInputUnitsIndex = 1
        fakeScene.selectedOutputUnitsIndex = 1
        
        // Run
        SUT.converterSceneOutputUnitsDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "11.6")
    }
}
