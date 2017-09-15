//
//  ConverterDelegate.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class ConverterController {
    
    var model: Model
    weak var scene: ConverterScene?
    
    init() {
        model = Model()
        self.model.observer = self
    }

    init(scene: ConverterScene) {
        model = Model()
        self.model.observer = self
        self.scene = scene
    }

    init(ingredients: [Ingredient],
         inputUnitsOptions: [VolumeUnit],
         outputUnitsOptions: [MassUnit]) {
        self.model = Model(ingredients: ingredients,
                           inputUnitsOptions: inputUnitsOptions,
                           outputUnitsOptions: outputUnitsOptions )
        self.model.observer = self
    }

    init(scene: ConverterScene,
         ingredients: [Ingredient],
         inputUnitsOptions: [VolumeUnit],
         outputUnitsOptions: [MassUnit]) {
        self.scene = scene
        self.model = Model(ingredients: ingredients,
                           inputUnitsOptions: inputUnitsOptions,
                           outputUnitsOptions: outputUnitsOptions )
        self.model.observer = self
    }
    
    var numberOfIngredients: Int { return model.ingredients.count }
    
    func nameForIngredientAtIndex(_ index: Int) -> String? {
        guard 0 <= index && index < model.ingredients.count else {
            return nil
        }

        return model.ingredients[index].name
    }
    
    var numberOfInputUnitsOptions: Int { return model.inputUnitsOptions.count }
    
    func nameForInputUnitOptionAtIndex(_ index: Int) -> String? {
        guard 0 <= index && index < model.inputUnitsOptions.count  else {
            return nil
        }
        return model.inputUnitsOptions[index].name
    }

    var numberOfOutputUnitsOptions: Int { return model.outputUnitsOptions.count }
    
    func nameForOutputUnitsOptionsAtIndex(_ index: Int) -> String? {
        guard 0 <= index && index < model.outputUnitsOptions.count else {
            return nil
        }
        return model.outputUnitsOptions[index].name
    }
    
    fileprivate func updateOutputTextForScene() {
        guard let inputText = model.inputText,
            let quantity = Double(inputText) else {
                scene?.outputText = "0"
                return
        }
        
        let selectedIngredient = model.ingredients[model.selectedIngredientIndex]
        let selectedInputUnits = model.inputUnitsOptions[model.selectedInputUnitIndex]
        let selectedOuputUnits = model.outputUnitsOptions[model.selectedOutputUnitIndex]
        
        let outputQuantity = model.convert(quantity, selectedInputUnits, of: selectedIngredient, to: selectedOuputUnits)
        scene?.outputText = String(format: "%.1f", outputQuantity)
    }
    
    func converterSceneInputTextDidChange() {
        model.inputText = scene?.inputText
        updateOutputTextForScene()
    }
    
    func converterSceneInputUnitsDidChange() {
        guard let selectedInputUnitsIndex = scene?.selectedInputUnitsIndex else {
            return
        }
        model.selectInputUnitsAtIndex(selectedInputUnitsIndex)
    }
    
    func converterSceneOutputUnitsDidChange() {
        guard let selectedOutputUnitsIndex = scene?.selectedOutputUnitsIndex else {
            return
        }
        model.selectOutputUnitsAtIndex(selectedOutputUnitsIndex)
    }
    
    func converterSceneIngredientDidChange() {
        guard let selectedIngredientIndex = scene?.selectedIngredientIndex else {
            return
        }
        model.selectIngredientAtIndex(selectedIngredientIndex)
    }
    
    func prepareDestinationScene(_ scene: SelectIngredientScene) {
        scene.controller = SelectIngredientController(model: model)
    }
}

extension ConverterController: ModelObserving {
    func modelWasUpdated() {
        updateOutputTextForScene()
    }
}
