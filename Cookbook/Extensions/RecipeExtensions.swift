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
    
    var ingredients: [[String : Any]] {
        guard let ingredients = ingredientsData as? [[String : Any]] else { return [[String : Any]]() }
        return ingredients
    }
    
    class IngredientKeys {
        static let amount = "amount"
        static let description = "ingredientDescription"
    }
    
    static func createRecipe(with title: String) -> Recipe {
        let recipesStore = RecipesStore.shared
        let recipe = Recipe(context: recipesStore.objectContext)
        
        recipe.id = UUID().uuidString
        recipe.creationDate = Date()
        recipe.title = title
        
        recipesStore.add(recipe)
        
        return recipe
    }
}
