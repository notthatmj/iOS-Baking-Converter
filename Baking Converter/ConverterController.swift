//
//  ConverterDelegate.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class ConverterController {
    
    var model: Model;
    
    init() {
        model = Model()
        self.model.observer = self
    }
    
    init(ingredients: [Ingredient], inputUnitsOptions: [VolumeUnit], outputUnitsOptions: [MassUnit]) {
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
    
    fileprivate func updateOutputTextForScene(_ scene: ConverterScene) {
        guard let inputText = model.inputText,
            let quantity = Double(inputText) else {
                scene.outputText = "0"
                return
        }
        
        let selectedIngredient = model.ingredients[model.selectedIngredientIndex]
        let selectedInputUnits = model.inputUnitsOptions[model.selectedInputUnitIndex]
        let selectedOuputUnits = model.outputUnitsOptions[model.selectedOutputUnitIndex]
        
        let outputQuantity = model.convert(quantity, selectedInputUnits, of: selectedIngredient, to: selectedOuputUnits)
        scene.outputText = String(format: "%.1f", outputQuantity)
    }
    
    func converterSceneInputTextDidChange(_ scene: ConverterScene) {
        model.inputText = scene.inputText
        updateOutputTextForScene(scene)
    }
    
    func converterSceneInputUnitsDidChange(_ scene: ConverterScene) {
        model.selectInputUnitsAtIndex(scene.selectedInputUnitsIndex)
        updateOutputTextForScene(scene)
    }
    
    func converterSceneOutputUnitsDidChange(_ scene: ConverterScene) {
        model.selectOutputUnitsAtIndex(scene.selectedOutputUnitsIndex)
        updateOutputTextForScene(scene)
    }
    
    func converterSceneIngredientDidChange(_ scene: ConverterScene) {
        model.selectIngredientAtIndex(scene.selectedIngredientIndex)
        updateOutputTextForScene(scene)
    }
    
    func prepareDestinationScene(_ scene: SelectIngredientScene) {
        scene.controller = SelectIngredientController(model: model)
    }
}

extension ConverterController: ModelObserving {
    func modelWasUpdated() { }
}
