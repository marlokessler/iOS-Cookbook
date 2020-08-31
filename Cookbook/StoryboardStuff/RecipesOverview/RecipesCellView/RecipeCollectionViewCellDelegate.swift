//
//  RecipeCollectionViewCellDelegate.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

protocol RecipeCollectionViewCellDelegate {
    func didPressDeleteButton(for recipe: Recipe, at indexPath: IndexPath)
}
