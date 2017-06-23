//
//  ConverterDelegate.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class ConverterController: ConverterSceneDelegate, ConverterSceneDataSource {
    
    private var model = Model();
    
    init() {}
    
    init(ingredients: [Ingredient], inputUnitsOptions: [VolumeUnit], outputUnitsOptions: [MassUnit]) {
        self.model = Model(ingredients: ingredients,
                           inputUnitsOptions: inputUnitsOptions,
                           outputUnitsOptions: outputUnitsOptions )
    }
    
    func numberOfIngredients() -> Int {
        return model.ingredients.count
    }
    
    func nameForIngredientAtIndex(_ index: Int) -> String? {
        guard case 0 ..< model.ingredients.count = index else {
            return nil
        }
        return model.ingredients[index].name
    }
    
    func numberOfInputUnitsOptions() -> Int {
        return model.inputUnitsOptions.count
    }
    
    func nameForInputUnitOptionAtIndex(_ index: Int) -> String? {
        guard case 0 ..< model.inputUnitsOptions.count = index  else {
            return nil
        }
        return model.inputUnitsOptions[index].name
    }
    
    func numberOfOutputUnitsOptions() -> Int {
        return model.outputUnitsOptions.count
    }
    
    func nameForOutputUnitsOptionsAtIndex(_ index: Int) -> String? {
        guard case 0 ..< model.outputUnitsOptions.count = index else {
            return nil
        }
        return model.outputUnitsOptions[index].name
    }

    func converterSceneInputTextDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterSceneInputUnitsDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterSceneOutputUnitsDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }
    
    func converterSceneIngredientDidChange(_ scene: ConverterScene) {
        updateOutputTextForScene(scene)
    }

    private func updateOutputTextForScene(_ scene: ConverterScene) {
        guard let inputText = scene.inputText,
            let quantity = Double(inputText) else {
            scene.outputText = "0"
            return
        }
        
        let selectedIngredient = model.ingredients[scene.selectedIngredientIndex]
        let selectedInputUnits = model.inputUnitsOptions[scene.selectedInputUnitsIndex]
        let selectedOuputUnits = model.outputUnitsOptions[scene.selectedOutputUnitsIndex]

        let outputQuantity = model.convert(quantity, selectedInputUnits, of: selectedIngredient, to: selectedOuputUnits)
        scene.outputText = String(format: "%.1f", outputQuantity)
    }
    
}
