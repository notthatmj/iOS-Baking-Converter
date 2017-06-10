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
}

class ConverterViewController: UIViewController, ConverterScene {

    var delegate: ConverterSceneDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = ConverterController()
    }

}

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return delegate.numberOfIngredients()
    }
}

extension ConverterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate.nameForIngredientAtIndex(row)
    }
}
