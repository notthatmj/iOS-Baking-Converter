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

    @IBOutlet weak var ingredientsPicker: UIPickerView!
    @IBOutlet weak var inputUnitsPicker: UIPickerView!
    @IBOutlet weak var outputUnitsPicker: UIPickerView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var controller: ConverterController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.layer.cornerRadius = 8.0
        resultsLabel.layer.masksToBounds = true
        controller = ConverterController()
    }

    @IBAction func textFieldEditingChangedAction(_ sender: Any) {
        controller.converterSceneInputTextDidChange(self)
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
        default:
            return controller.numberOfIngredients
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
        default:
            return controller.nameForIngredientAtIndex(row)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case inputUnitsPicker:
            controller.converterSceneInputUnitsDidChange(self)
        case outputUnitsPicker:
            controller.converterSceneOutputUnitsDidChange(self)
        case ingredientsPicker:
            controller.converterSceneIngredientDidChange(self)
        default:
            break
        }
    }
}

protocol ConverterScene: class {
    var inputText: String? { get }
    var outputText: String? {get set}
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

