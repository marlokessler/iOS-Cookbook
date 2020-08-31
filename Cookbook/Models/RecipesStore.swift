//
//  RecipesStore.swift
//  Cookbook
//
//  Created by Marlo Kessler on 29.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class RecipesStore: Store<Recipe> {
    
    
    
    private init() {
        super.init(entityName: "Recipe")
    }
    
    
    
    // MARK: - Properties
    static let shared = RecipesStore()
    
    
    // MARK: - Methods
    
    override func add(_ value: Recipe) {
        super.add(value)
        Update.added(value).post()
    }

    override func update(_ value: Recipe) {
        super.update(value)
        Update.changed(value).post()
    }

    override func delete(_ value: Recipe) {
        super.delete(value)
        Update.deleted(value).post()
    }
    
    
    
    // MARK: - Enums
    enum Update {
        case added(_ recipe: Recipe)
        case changed(_ recipe: Recipe)
        case deleted(_ recipe: Recipe)

        static let notificationName = Notification.Name(rawValue: "recipesStoreUpdateNotification")

        func post() {
            switch self {
            case .added(recipe: _): NotificationCenter.default.post(name: Update.notificationName, object: self)
            case .changed(recipe: _): NotificationCenter.default.post(name: Update.notificationName, object: self)
            case .deleted(recipe: _): NotificationCenter.default.post(name: Update.notificationName, object: self)
            }
        }
    }
}
