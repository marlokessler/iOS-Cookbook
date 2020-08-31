//
//  IngredientsViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 31.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class IngredientsViewController: RecipeViewContainerController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: AddButton!
    @IBOutlet weak var buttonContainerHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
