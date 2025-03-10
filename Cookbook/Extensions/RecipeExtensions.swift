//
//  RecipeExtensions.swift
//  Cookbook
//
//  Created by Marlo Kessler on 21.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData

extension Recipe {
    
    var duration: TimeInterval { worktime + resttime }
    
    var ingredients: [[String : Any]] {
        guard let ingredients = ingredientsData as? [[String : Any]] else { return [[String : Any]]() }
        return ingredients
    }
    
    class IngredientKeys {
        static let amount = "amount"
        static let description = "ingredientDescription"
    }
}
