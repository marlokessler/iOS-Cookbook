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
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                Crashlytics.crashlytics().record(error: error)
            }
        }
        
        return container
    }()
    
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
}
