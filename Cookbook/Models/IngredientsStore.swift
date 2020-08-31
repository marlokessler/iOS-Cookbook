//
//  IngredientsStore.swift
//  Cookbook
//
//  Created by Marlo Kessler on 29.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class IngredientsStore: Store<Ingredient> {
    
    
    
    private init() {
        super.init(entityName: "Ingredient")
    }
    
    
    
    // MARK: - Properties
    static let shared = IngredientsStore()
    
    
    // MARK: - Methods
    
    override func add(_ value: Ingredient) {
        super.add(value)
        Update.added(value).post()
    }

    override func update(_ value: Ingredient) {
        super.update(value)
        Update.changed(value).post()
    }

    override func delete(_ value: Ingredient) {
        super.delete(value)
        Update.deleted(value).post()
    }
    
    
    
    // MARK: - Enums
    enum Update {
        case added(_ ingredient: Ingredient)
        case changed(_ ingredient: Ingredient)
        case deleted(_ ingredient: Ingredient)

        static let notificationName = Notification.Name(rawValue: "recipesStoreUpdateNotification")

        func post() {
            switch self {
            case .added(ingredient: _): NotificationCenter.default.post(name: Update.notificationName, object: self)
            case .changed(ingredient: _): NotificationCenter.default.post(name: Update.notificationName, object: self)
            case .deleted(ingredient: _): NotificationCenter.default.post(name: Update.notificationName, object: self)
            }
        }
    }
}
