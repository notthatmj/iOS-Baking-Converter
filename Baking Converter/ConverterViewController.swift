
//
//  ConverterViewController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 6/10/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

protocol ConverterScene {
    
}

protocol ConverterSceneDelegate {
    func numberOfIngredients() -> Int
    func nameForIngredientAtIndex(_ index: Int) -> String?
    func numberOfInputUnitsOptions() -> Int
    func nameForInputUnitOptionAtIndex(_ index: Int) -> String?
    func numberOfOutputUnitsOptions() -> Int
    func nameForOutputUnitsOptionsAtIndex(_ index: Int) -> String?
}

class ConverterViewController: UIViewController, ConverterScene {

    @IBOutlet weak var inputUnitsPicker: UIPickerView!
    @IBOutlet weak var outputUnitsPicker: UIPickerView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var delegate: ConverterSceneDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.layer.cornerRadius = 8.0
        resultsLabel.layer.masksToBounds = true
        delegate = ConverterController()
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