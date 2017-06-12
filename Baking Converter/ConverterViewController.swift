//
//  ConverterViewController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit
//import Foundation

protocol ConverterScene: AnyObject {
    var inputText: String? { get }
    var outputText: String? {get set}
    var selectedIngredientIndex: Int { get }
}

protocol ConverterSceneDelegate {
    func numberOfIngredients() -> Int
    func nameForIngredientAtIndex(_ index: Int) -> String?
    func numberOfInputUnitsOptions() -> Int
    func nameForInputUnitOptionAtIndex(_ : Int) -> String?
    func numberOfOutputUnitsOptions() -> Int
    func nameForOutputUnitsOptionsAtIndex(_ : Int) -> String?
    func converterSceneInputTextDidChange(_ : ConverterScene)
}

class ConverterViewController: UIViewController {

    @IBOutlet weak var ingredientsPicker: UIPickerView!
    @IBOutlet weak var inputUnitsPicker: UIPickerView!
    @IBOutlet weak var outputUnitsPicker: UIPickerView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var delegate: ConverterSceneDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.layer.cornerRadius = 8.0
        resultsLabel.layer.masksToBounds = true
        delegate = ConverterController()
    }

    @IBAction func textFieldEditingChangedAction(_ sender: Any) {
        delegate.converterSceneInputTextDidChange(self)
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
}

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case inputUnitsPicker:
            return delegate.numberOfInputUnitsOptions()
        case outputUnitsPicker:
            return delegate.numberOfOutputUnitsOptions()
        default:
            return delegate.numberOfIngredients()
        }
    }
}

extension ConverterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case inputUnitsPicker:
            return delegate.nameForInputUnitOptionAtIndex(row)
        case outputUnitsPicker:
            return delegate.nameForOutputUnitsOptionsAtIndex(row)
        default:
            return delegate.nameForIngredientAtIndex(row)
        }
    }
    
}
