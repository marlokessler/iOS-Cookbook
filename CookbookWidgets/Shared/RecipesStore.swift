//
//  RecipesStore.swift
//  Cookbook
//
//  Created by Marlo Kessler on 06.10.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class RecipesStore {
    
    
    
    private init() {}
    
    
    
    private static let containerName = "Model"
    private static let entityName = "Recipe"
    
    
    
    static func fetchRecipesData(completion: @escaping ([RecipeData]?) -> Void) {
        loadPersistentContainer { container, error in
            guard error == nil,
                  let objectContext = container?.viewContext,
                  let recipes = fetchRecipes(from: objectContext) else {
                completion(nil)
                return
            }
            
            let recipesData = transform(recipes)
            completion(recipesData)
        }
    }
    
    private static func loadPersistentContainer(completion: @escaping (NSPersistentContainer?, Error?) -> Void) {
        let container = NSPersistentContainer(name: containerName)
        
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.connapptivity.cookbook.cookbookapp.database")
        else { fatalError("Shared file container could not be created.") }

        let storeURL = fileContainer.appendingPathComponent("CookbookDB.sqlite")
        print("Group URL OF OFFICIAl STORE: \(storeURL)")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                Crashlytics.crashlytics().record(error: error)
                completion(nil, error)
                return
            }
            
            completion(container, nil)
        }
    }
    
    private static func fetchRecipes(from objectContext: NSManagedObjectContext) -> [Recipe]? {
        let fetchRequest = NSFetchRequest<Recipe>(entityName: entityName)

        do {
            let recipes = try objectContext.fetch(fetchRequest)
            return recipes
        } catch let error as NSError {

            Crashlytics.crashlytics().record(error: error)

            #if DEBUG
            print("Could not fetch recipes from store: \(error), \(error.userInfo)")
            #endif
            
            return nil
        }
    }
    
    private static func transform(_ recipes: [Recipe]) -> [RecipeData] {
        let sortedRecipes = recipes.sorted { lhs, rhs in
            guard let lhsDate = lhs.creationDate, let rhsDate = rhs.creationDate else { return false }
            return lhsDate > rhsDate
        }
        
        var recipesData = [RecipeData]()
        for recipe in sortedRecipes {
            let data = RecipeData(from: recipe)
            recipesData.append(data)
        }
        
        return recipesData
    }
}
