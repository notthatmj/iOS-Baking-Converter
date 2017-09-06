//
//  SelectIngredientViewController.swift
//  Baking Converter
//
//  Created by Michael Johnson on 8/21/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit

class SelectIngredientViewController: UIViewController, UINavigationBarDelegate {

    var controller: SelectIngredientController!
    
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

extension SelectIngredientViewController: SelectIngredientScene { }

extension SelectIngredientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = controller.titleForCellAtIndex(indexPath.row)
        cell.textLabel?.text = title
        return cell
    }
}
