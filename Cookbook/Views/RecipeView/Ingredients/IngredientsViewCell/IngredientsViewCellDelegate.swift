//
//  IngredientsViewCellDelegate.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

protocol IngredientsViewCellDelegate {
    func ingredientDidChange(amount: Double, at indexPath: IndexPath)
    func ingredientDidChange(description: String, at indexPath: IndexPath)
    func ingredientCellDidEndEditing(with amount: Double, and description: String, at indexPath: IndexPath)
}
