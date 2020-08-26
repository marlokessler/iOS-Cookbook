//
//  Store.swift
//  Cookbook
//
//  Created by Marlo Kessler on 23.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class Store {



    private init() {
        fetchRecipes()
    }



    // MARK: - Properties
    static let shared = Store()


    var recipes = [Recipe]()



    private var objectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Model")
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()


    // MARK: - Methods
    private func fetchRecipes() {
        let fetchRequest = NSFetchRequest<Recipe>(entityName: Store.Entity.recipe)

        do {
            recipes = try objectContext.fetch(fetchRequest)
        } catch let error as NSError {

            Crashlytics.crashlytics().record(error: error)

            #if DEBUG
            print("Could not fetch recipes from store: \(error), \(error.userInfo)")
            #endif
        }
    }

    func addRecipe(_ recipe: Recipe) {
        storeChanges()
        RecipesStoreUpdate.added(recipe).post()
    }

    func updateRecipe(_ recipe: Recipe) {
        storeChanges()
        RecipesStoreUpdate.changed(recipe).post()
    }

    func deleteRecipe(_ recipe: Recipe) {
        storeChanges()
        RecipesStoreUpdate.deleted(recipe).post()
    }

    private func storeChanges() {
        do {
            try objectContext.save()
        } catch let error as NSError {

            Crashlytics.crashlytics().record(error: error)

            #if DEBUG
            print("Could not store changes: \(error), \(error.userInfo)")
            #endif
        }
    }



    // MARK: - Classes
    private class Entity {
        static let recipe = "Recipe"
    }



    // MARK: - Enums
    enum RecipesStoreUpdate {
        case added(_ recipe: Recipe)
        case changed(_ recipe: Recipe)
        case deleted(_ recipe: Recipe)

        static let recipesStoreUpdateNotificationName = Notification.Name(rawValue: "recipesStoreUpdateNotification")

        func post() {
            switch self {
            case .added(recipe: _): NotificationCenter.default.post(name: RecipesStoreUpdate.recipesStoreUpdateNotificationName, object: self)
            case .changed(recipe: _): NotificationCenter.default.post(name: RecipesStoreUpdate.recipesStoreUpdateNotificationName, object: self)
            case .deleted(recipe: _): NotificationCenter.default.post(name: RecipesStoreUpdate.recipesStoreUpdateNotificationName, object: self)
            }
        }
    }
}
