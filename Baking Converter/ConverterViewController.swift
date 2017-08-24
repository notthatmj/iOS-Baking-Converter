//
//  ConverterViewController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit
import Foundation

protocol ConverterScene: AnyObject {
    var inputText: String? { get }
    var outputText: String? {get set}
    var selectedIngredientIndex: Int { get }
    var selectedInputUnitsIndex: Int { get }
    var selectedOutputUnitsIndex: Int { get }
}

protocol ConverterSceneDataSource {
    func numberOfIngredients() -> Int
    func nameForIngredientAtIndex(_ index: Int) -> String?
    func numberOfInputUnitsOptions() -> Int
    func nameForInputUnitOptionAtIndex(_ : Int) -> String?
    func numberOfOutputUnitsOptions() -> Int
    func nameForOutputUnitsOptionsAtIndex(_ : Int) -> String?
}

protocol ConverterSceneDelegate {
    func converterSceneInputTextDidChange(_ : ConverterScene)
    func converterSceneInputUnitsDidChange(_ : ConverterScene)
    func converterSceneOutputUnitsDidChange(_ : ConverterScene)
    func converterSceneIngredientDidChange(_ : ConverterScene)
}

class ConverterViewController: UIViewController {

    @IBOutlet weak var ingredientsPicker: UIPickerView!
    @IBOutlet weak var inputUnitsPicker: UIPickerView!
    @IBOutlet weak var outputUnitsPicker: UIPickerView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
//    var delegate: ConverterSceneDelegate!
//    var dataSource: ConverterSceneDataSource!
    var controller: (ConverterSceneDelegate & ConverterSceneDataSource)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.layer.cornerRadius = 8.0
        resultsLabel.layer.masksToBounds = true
//        let controller = ConverterController()
//        delegate = controller
//        dataSource = controller
        controller = ConverterController()
    }

    @IBAction func textFieldEditingChangedAction(_ sender: Any) {
        controller.converterSceneInputTextDidChange(self)
    }
    
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

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case inputUnitsPicker:
            return controller.numberOfInputUnitsOptions()
        case outputUnitsPicker:
            return controller.numberOfOutputUnitsOptions()
        default:
            return controller.numberOfIngredients()
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
        case ingredientsPicker:
            controller.converterSceneIngredientDidChange(self)
            break
        case inputUnitsPicker:
            controller.converterSceneInputUnitsDidChange(self)
        case outputUnitsPicker:
            controller.converterSceneOutputUnitsDidChange(self)
        default:
            break
        }
        return
    }
}
