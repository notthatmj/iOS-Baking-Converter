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
    func converterScene(_ : ConverterScene, didSelectIngredientAtIndex: Int) {
        
    }
}

class ConverterControllerTests: XCTestCase {

    var SUT: ConverterController!

    let testIngredients: [Ingredient] = [ Ingredient(name: "All-Purpose Flour", gramsPerCup: 120.0),
                                          Ingredient(name: "Cake Flour", gramsPerCup: 120.0),
                                          Ingredient(name: "Sugar", gramsPerCup: 198.0),
                                          Ingredient(name: "Soylent", gramsPerCup: 321.0)]
    
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
            XCTAssertEqual(ingredientNames[index], testIngredients[index].name)
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
    
    func testInputValueWasChangedForScene1() {
        // Setup
        let fakeScene = FakeConverterScene()
        fakeScene.inputText = "1"
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "120.0")
    }

    func testInputValueWasChangedForScene2() {
        // Setup
        let fakeScene = FakeConverterScene()
        fakeScene.inputText = "2"
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "240.0")
    }

    func testInputValueWasChangedForScene3() {
        // Setup
        let fakeScene = FakeConverterScene()
        fakeScene.inputText = "1"
        fakeScene.selectedIngredientIndex = 2
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "198.0")
    }

    func testInputValueWasChangedForScene4() {
        // Setup
        let fakeScene = FakeConverterScene()
        fakeScene.inputText = "3"
        fakeScene.selectedIngredientIndex = 2
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "594.0")
    }

    func testInputValueWasChangedForSceneWithBadInput() {
        // Setup
        let fakeScene = FakeConverterScene()
        fakeScene.inputText = "2.."
        
        // Run
        SUT.converterSceneInputTextDidChange(fakeScene)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText, "0")
    }
    
    func testSceneDidSelectIngredientAtIndex() {
        // Setup
        let fakeScene = FakeConverterScene()
        fakeScene.inputText = "1"
        fakeScene.selectedIngredientIndex = 2
        
        // Run
        SUT.converterScene(fakeScene, didSelectIngredientAtIndex:2)
        
        // Assert
        XCTAssertEqual(fakeScene.outputText ,"198.0")
    }
}
