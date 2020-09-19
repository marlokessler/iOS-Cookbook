//
//  RecipesCoordinatorProtocol.swift
//  Cookbook
//
//  Created by Marlo Kessler on 19.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

protocol RecipesCoordinatorProtocol {
    func createRecipe()
    func show(_ recipe: Recipe, inEditMode: Bool, animated: Bool)
}
