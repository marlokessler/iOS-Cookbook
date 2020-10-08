//
//  AppVersioner.swift
//  Cookbook
//
//  Created by Marlo Kessler on 19.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import WidgetKit
import CoreData
import Firebase

class AppVersioner {
    
    
    
    private init() {
        prepareForVersioning()
        setPreviousVersion()
    }
    
    static let shared = AppVersioner()
    
    
    
    static func initialize() {
        shared.updateVersion()
    }
    
    
    
    var currentVersion: Version? {
        guard let versionString = defaults?.string(forKey: versionKey)  else { return nil }
        let version = Version(rawValue: versionString)
        return version
    }
    
    private(set) var previousVersion: Version?
    
    var appHasNewVersion: Bool { currentVersion != previousVersion }
    
    
    
    private let defaults = UserDefaults(suiteName: "Versioner")
    private let versionKey = "StoredAppVersion"
    
    
    
    private func setPreviousVersion() {
        previousVersion = currentVersion
    }
    
    
    
    private func prepareForVersioning() {
        let currentlyStoredVersion = currentVersion
        if currentlyStoredVersion == nil {
            // MUST EXPECT VERSION 1.0.0
            set(version: .v1_0_0)
        }
    }
    
    private func updateVersion() {
        let currentlyStoredVersion = currentVersion
        switch currentlyStoredVersion {
        case .v1_0_0: updateTo_1_1_0()
        case .v1_1_0: updateTo_1_2_0()
        default: return
        }
        updateVersion()
    }
    
    private func set(version: Version) {
        print("APPVERSIONER SET VERSION: \(version.rawValue)")
        defaults?.set(version.rawValue, forKey: versionKey)
    }
    
    
    
    // MARK: - Version
    enum Version: String, CaseIterable, Comparable {
        case v1_0_0 = "1.0.0"
        case v1_1_0 = "1.1.0"
        case v1_2_0 = "1.2.0"
        
        static func < (lhs: AppVersioner.Version, rhs: AppVersioner.Version) -> Bool {
            let lhsIndex = allCases.firstIndex(of: lhs)!
            let rhsIndex = allCases.firstIndex(of: rhs)!
            return lhsIndex < rhsIndex
        }
        
        var followingVersion: Self? {
            let index          = Version.allCases.firstIndex(of: self)!
            let followingIndex = index + 1
            
            if Version.allCases.count > followingIndex {
                return Version.allCases[followingIndex]
            }
            return nil
        }        
    }
}



// MARK: - 1.1.0
// Updates: There is no id and creationDate set with any recipes. Those will be set.
extension AppVersioner {
    private func updateTo_1_1_0() {
        addIDAndCreationDateToRecipes()
        set(version: .v1_1_0)
    }
    
    private func addIDAndCreationDateToRecipes() {
        let recipeStore = RecipesStore.shared
        
        for recipe in recipeStore.values {
            var didChangeRecipe = false
            if recipe.id == nil  {
                recipe.id = UUID().uuidString
                didChangeRecipe = true
            }
            if recipe.creationDate == nil {
                recipe.creationDate = Date()
                didChangeRecipe = true
            }
            
            if didChangeRecipe {
                recipeStore.update(recipe)
            }
        }
    }
}



// MARK: - 1.2.0
// Updates: The recipes database will be moved to an app container, so also extensions can access them.
extension AppVersioner {
    private func updateTo_1_2_0() {
        moveRecipesDBToContainer { error in
            guard error == nil else { return }
            self.set(version: .v1_2_0)
        }
    }
    
    private func moveRecipesDBToContainer(completion: @escaping (V1_2_0_Error?) -> Void) {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                Crashlytics.crashlytics().record(error: error)
                completion(V1_2_0_Error.loadPersistentStoreError)
                return
            }
            
            guard let recipes = self.fetchRecipesFromOldStore(with: container.viewContext) else {
                completion(V1_2_0_Error.fetchRecipesError)
                return
            }
                        
            self.transferRecipesToNewStore(recipes)
            
            completion(nil)
            
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    
    private func transferRecipesToNewStore(_ recipes: [Recipe]) {
        let recipesStore = RecipesStore.shared
        
        for recipe in recipes {
            let newRecipe = Recipe(context: recipesStore.objectContext)
            
            newRecipe.id           = recipe.id
            newRecipe.creationDate = recipe.creationDate
            
            newRecipe.image    = recipe.image
            newRecipe.title    = recipe.title
            newRecipe.portions = recipe.portions
            
            newRecipe.worktime = recipe.worktime
            newRecipe.resttime = recipe.resttime
            
            newRecipe.ingredientsData = recipe.ingredientsData
            newRecipe.instructions    = recipe.instructions
            
            recipesStore.add(recipe)
        }
    }
    
    private func fetchRecipesFromOldStore(with context: NSManagedObjectContext) -> [Recipe]? {
        let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")

        do {
            let values = try context.fetch(fetchRequest)
            return values
        } catch let error as NSError {

            Crashlytics.crashlytics().record(error: error)

            #if DEBUG
            print("Could not fetch recipes from old store: \(error), \(error.userInfo)")
            #endif
            
            return nil
        }
    }
    
    private enum V1_2_0_Error: Error {
        case loadPersistentStoreError
        case fetchRecipesError
    }
}



// MARK: - 1.3.0
// Updates:
// - The old recipesDB, from which the recipes were transfered t the new one, will be removed.
//extension AppVersioner {
//    private func updateTo_1_3_0() {
//        self.removeOldRecipesStore()
//    }
//
//    private func removeOldRecipesStore() {
//        let fm = FileManager.default
//        let supportDirURL = try! fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//        let sqliteURL    = supportDirURL.appendingPathComponent("Model.sqlite")
//        let sqliteShmURL = supportDirURL.appendingPathComponent("Model.sqlite-shm")
//        let sqliteWalURL = supportDirURL.appendingPathComponent("Model.sqlite-wal")
//
//        try? fm.removeItem(at: sqliteURL)
//        try? fm.removeItem(at: sqliteShmURL)
//        try? fm.removeItem(at: sqliteWalURL)
//    }
//}
