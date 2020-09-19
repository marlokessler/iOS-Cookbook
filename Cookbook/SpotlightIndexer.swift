//
//  SpotlightIndexer.swift
//  Cookbook
//
//  Created by Marlo Kessler on 18.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreSpotlight
import FirebaseCrashlytics

class SpotlightIndexer {
    
    private init() {}
    
    private static let shared = SpotlightIndexer()
    
    static func initialize() {
        asynchronously { shared.indexRecipes() }
    }
    
    
    
    // MARK: - Recipes Index
    private func indexRecipes() {
        let searchableIndex = CSSearchableIndex.default()
        searchableIndex.deleteSearchableItems(withDomainIdentifiers: ["Recipes"]) { error in
            guard error == nil else { return }
            
            let recipes = RecipesStore.shared.values
            var indexItems = [CSSearchableItem]()
            
            for recipe in recipes {
                guard let indexItem = self.getSearchableItem(for: recipe) else { break }
                indexItems.append(indexItem)
            }
            
            searchableIndex.indexSearchableItems(indexItems) { (error) in }
        }
    }
    
    
    
    private func getSearchableItem(for recipe: Recipe) -> CSSearchableItem? {
        guard let id = recipe.id else { return nil }
        let attributeSet = createAttributeSet(for: recipe)
        let indexItem = CSSearchableItem(uniqueIdentifier: id, domainIdentifier: "Recipes", attributeSet: attributeSet)
        indexItem.expirationDate = indexExpirationDate
        return indexItem
    }
    
    private func createAttributeSet(for recipe: Recipe) -> CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: "Recipe")
        attributeSet.addedDate           = recipe.creationDate
        attributeSet.contentCreationDate = recipe.creationDate
        attributeSet.contentType         = "Recipe".localized()
        attributeSet.displayName         = recipe.title
        attributeSet.duration            = NSNumber(value: recipe.duration)
        attributeSet.genre               = "Recipes".localized()
        attributeSet.headline            = recipe.title
        attributeSet.identifier          = recipe.id
        attributeSet.information         = recipe.title
        attributeSet.keywords            = recipe.ingredients.map { $0[Recipe.IngredientKeys.description] as? String ?? "" }
        attributeSet.kind                = "Recipe".localized()
        attributeSet.local               = 1
        attributeSet.mediaTypes          = ["Image", "Text"]
        attributeSet.subject             = "Recipe".localized()
        attributeSet.textContent         = recipeTextContent(for: recipe)
        attributeSet.thumbnailData       = recipe.image
        attributeSet.timestamp           = recipe.creationDate
        attributeSet.title               = recipe.title
        attributeSet.userCreated         = 1
        attributeSet.userCurated         = 1
        attributeSet.userOwned           = 1
        
        return attributeSet
    }
    
    private var indexExpirationDate: Date {
        let oneYearInSeconds: TimeInterval = 31556952
        let exposureDate = Date(timeInterval: oneYearInSeconds, since: Date())
        return exposureDate
    }
    
    private func recipeTextContent(for recipe: Recipe) -> String {
        let ingredientsArray   = recipe.ingredients.map { "\($0[Recipe.IngredientKeys.amount] as? Double ?? 0) \($0[Recipe.IngredientKeys.description] as? String ?? "")" }
        let instructionsArray  = recipe.instructions as? [String] ?? [String]()
        let unitedArray = ingredientsArray + instructionsArray
        return unitedArray.joined(separator: ", ")
    }
}
