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
    var controller: SelectIngredientController! {get set}
}

extension SelectIngredientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        controller.titleForCellAtIndex(indexPath.row)
        return cell
    }
}
