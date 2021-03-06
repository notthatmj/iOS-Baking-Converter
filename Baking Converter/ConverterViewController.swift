//
//  ConverterViewController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit
import Foundation

class ConverterViewController: UIViewController {

    @IBOutlet var ingredientsPicker: UIPickerView!
    @IBOutlet var inputUnitsPicker: UIPickerView!
    @IBOutlet var outputUnitsPicker: UIPickerView!
    @IBOutlet var ingredientButton: UIButton!
    @IBOutlet var inputField: UITextField!
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var changeIngredientButton: UIButton!

    var controller: ConverterController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure results label with rounded corners
        resultsLabel.layer.cornerRadius = 8.0
        resultsLabel.layer.masksToBounds = true
        controller = ConverterController(scene: self)
    }
    
    @IBAction func textFieldEditingChangedAction(_ sender: Any) {
        controller.converterSceneInputTextDidChange()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationScene = segue.destination as? SelectIngredientScene else {
            return
        }
        controller.prepareDestinationScene(destinationScene)
    }
    
}

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case inputUnitsPicker:
            return controller.numberOfInputUnitsOptions
        case outputUnitsPicker:
            return controller.numberOfOutputUnitsOptions
        case ingredientsPicker:
            return controller.numberOfIngredients
        default:
            // We should never reach this default case
            return 0
        }
    }
}

extension ConverterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case inputUnitsPicker:
            return controller.nameForInputUnitOptionAtIndex(row)
        case outputUnitsPicker:
            return controller.nameForOutputUnitsOptionsAtIndex(row)
        case ingredientsPicker:
            return controller.nameForIngredientAtIndex(row)
        default:
            // We should never reach this default case
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case inputUnitsPicker:
            controller.converterSceneInputUnitsDidChange()
        case outputUnitsPicker:
            controller.converterSceneOutputUnitsDidChange()
        case ingredientsPicker:
            controller.converterSceneIngredientDidChange()
        default:
            // We should never reach this default case
            return
        }
    }
}

protocol ConverterScene: class {
    var inputText: String? { get }
    var outputText: String? {get set}
    var ingredientButtonText: String? {get set}
    var selectedIngredientIndex: Int { get }
    var selectedInputUnitsIndex: Int { get }
    var selectedOutputUnitsIndex: Int { get }
}

extension ConverterViewController: ConverterScene {
    
    var inputText: String? {
        return inputField.text
    }
    
    var outputText: String? {
        get {
            return resultsLabel.text
        }
        set {
            resultsLabel.text = newValue
        }
    }
    
    var ingredientButtonText: String? {
        get {
            return ingredientButton.currentTitle
        }
        set {
            ingredientButton.setTitle(newValue, for: UIControlState.normal)
        }
    }
    var selectedIngredientIndex: Int {
        return ingredientsPicker.selectedRow(inComponent: 0)
    }
    
    var selectedInputUnitsIndex: Int {
        return inputUnitsPicker.selectedRow(inComponent: 0)
    }
    
    var selectedOutputUnitsIndex: Int {
        return outputUnitsPicker.selectedRow(inComponent: 0)
    }
    
}

