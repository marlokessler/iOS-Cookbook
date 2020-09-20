//
//  SceneDelegate.swift
//  Cookbook
//
//  Created by Marlo Kessler on 07.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData
import WhatsNewKit
import CoreSpotlight

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var coordinator: MainCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setRootView(for: scene)
        coordinator?.showFeaturesIfUnshown()
        connectionOptions.userActivities.forEach { userActivity in
            self.handle(userActivity)
            
        }
    }
    
    private func setRootView(for scene: UIScene) {
        let navController = UINavigationController()
        coordinator = MainCoordinator(rootViewController: navController)
        coordinator?.start()
        
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        handle(userActivity)
    }
    
    private func handle(_ userActivity: NSUserActivity) {
        switch userActivity.activityType {
        case CSSearchableItemActionType: handleSearch(userActivity: userActivity)
        default: break
        }
    }
    
    private func handleSearch(userActivity: NSUserActivity) {
        guard
            let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String,
            let selectedRecipe = RecipesStore.shared.values.first(where: { $0.id == uniqueIdentifier })
        else { return }
        coordinator!.show(selectedRecipe, inEditMode: false, animated: false)
    }
}
