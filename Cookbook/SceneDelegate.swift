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
import WidgetKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var coordinator: MainCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setRootView(for: scene)
        coordinator?.showFeaturesIfUnshown()
        
        connectionOptions.userActivities.forEach { userActivity in
            self.scene(scene, continue: userActivity)
        }
        self.scene(scene, openURLContexts: connectionOptions.urlContexts)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for urlcontext in URLContexts {
            let url = urlcontext.url
            switch url.scheme {
            case "openrecipe":
                guard let id = url.host else { return }
                openRecipe(with: id)
            case "createrecipe":
                coordinator?.createRecipe()
            default: break
            }
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
        switch userActivity.activityType {
        case CSSearchableItemActionType: handleSearch(userActivity: userActivity)
        default: break
        }
    }
    
    private func handleSearch(userActivity: NSUserActivity) {
        guard let id = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String
        else { return }
        openRecipe(with: id)
    }
    
    private func openRecipe(with id: String) {
        guard let selectedRecipe = RecipesStore.shared.values.first(where: { $0.id == id })
        else { return }
        coordinator?.show(selectedRecipe, inEditMode: false, animated: false)
    }
}
