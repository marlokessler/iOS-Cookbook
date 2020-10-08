//
//  WidgetsConnector.swift
//  Cookbook
//
//  Created by Marlo Kessler on 21.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import WidgetKit

@available(iOS 14, *)
class WidgetsConnector {
    
    private init() {}
    
    private static let shared = WidgetsConnector()
    
    static func initialize() {
        NotificationCenter.default.addObserver(shared, selector: #selector(shared.recipeChanges(notification:)), name: RecipesStore.Update.notificationName, object: nil)
    }
    
    @objc private func recipeChanges(notification: Notification) {
        #if DEBUG
        print("Received a \"recipes changed\" notification in \(String(describing: self)).")
        #endif
        
        WidgetCenter.shared.reloadTimelines(ofKind: "LatestRecipesWidget")
    }
}
