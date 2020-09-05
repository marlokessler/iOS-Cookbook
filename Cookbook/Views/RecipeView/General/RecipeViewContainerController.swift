//
//  RecipeViewContainerController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class RecipeViewContainerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }
    
    private func configureSelf() {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
