//
//  Store.swift
//  Cookbook
//
//  Created by Marlo Kessler on 23.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData
import FirebaseCrashlytics

class PersistentContainer {
    // Is in this container superclass because the generic class Store may not include static properties.
    static let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                Crashlytics.crashlytics().record(error: error)
            }
        }
        
        return container
    }()
}


class Store<T: NSManagedObject>: PersistentContainer {
    
    
    
    init(entityName: String) {
        super.init()
        self.entityName = entityName
        fetch()
    }
    
    
    
    var objectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        configure(container)
        container.loadPersistentStores { _, error in
            if let error = error  {
                Crashlytics.crashlytics().record(error: error)
            }
        }
        
        return container
    }()
    
    private static func configure(_ container: NSPersistentContainer) {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.connapptivity.cookbook.cookbookapp.database")
        else {
            Crashlytics.crashlytics().record(error: StoreError.loadContainerURLError)
            fatalError("Shared file container could not be created.")
        }

        let storeURL = fileContainer.appendingPathComponent("CookbookDB.sqlite")
        #if DEBUG
        print("Group URL CookbookDB: \(storeURL)")
        #endif
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]
    }
    
    private(set) var values = [T]()
    
    private var entityName = ""
    
    // MARK: - Methods
    private func fetch() {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)

        do {
            values = try objectContext.fetch(fetchRequest)
        } catch let error as NSError {

            Crashlytics.crashlytics().record(error: error)

            #if DEBUG
            print("Could not fetch recipes from store: \(error), \(error.userInfo)")
            #endif
        }
    }
    
    func add(_ value: T) {
        storeChanges()
    }
    
    func update(_ value: T) {
        storeChanges()
    }
    
    func delete(_ value: T) {
        objectContext.delete(value)
        storeChanges()
    }
    
    private func storeChanges() {
        do {
            try objectContext.save()
            fetch()
        } catch let error as NSError {
            
            Crashlytics.crashlytics().record(error: error)
            
            #if DEBUG
            print("Could not store changes: \(error), \(error.userInfo)")
            #endif
        }
    }
    
    private enum StoreError: Error {
        case loadContainerURLError
    }
}
