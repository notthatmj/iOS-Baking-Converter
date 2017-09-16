//
//  SelectingIngredientController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 8/31/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import Foundation

class SelectIngredientController {
    let model: Model
    
    init(model: Model) {
        self.model = model
    }
    
    func titleForCellAtIndex(_ index: Int) -> String {
        guard 0 <= index && index < model.ingredients.count else {
            return ""
        }
        return model.ingredients[index].name
    }
    
    func numberOfRows() -> Int {
        return model.ingredients.count
    }
    
    func selectIngredientAtIndex(_ index: Int) {
        model.selectedIngredientIndex = index
    }

}
