//
//  SelectIngredientViewController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 8/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

class SelectIngredientViewController: UIViewController, UINavigationBarDelegate {

    @IBAction func cancelButtonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

protocol SelectIngredientScene: class {
    var model: Model! {get set}
}
