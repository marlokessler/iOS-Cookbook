//
//  RecipeExtensions.swift
//  Cookbook
//
//  Created by Marlo Kessler on 21.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData
import Firebase

extension Recipe {
    
    var duration: TimeInterval { worktime + resttime }
    
    var ingredients: [Ingredient] {
        
        let ingredientsForThisRecipe = IngredientsStore.shared.values.filter { ingredient in
            let parentID = ingredient.parent?.id
            return parentID != nil && parentID == id
        }
        
        return ingredientsForThisRecipe
    }
}
