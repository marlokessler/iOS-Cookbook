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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if let window = window,
            let navController = window.rootViewController as? UINavigationController,
            let viewController = navController.visibleViewController as? RecipesOverviewController {
            Introscreen.initialize(on: viewController)
        }
    }
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        let recipesOverview = RecipesOverview()
//
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            let rootViewController = ContentHostingController(rootView: recipesOverview.environment(\.managedObjectContext, context))
//            window.rootViewController = rootViewController
//            self.window = window
//            window.makeKeyAndVisible()
//
//            // Show intro screen, if not shown before
//        }
    }
    
    
    // MARK: - Change status bar style
//    class ContentHostingController<T: View>: UIHostingController<T> {
//        override var preferredStatusBarStyle: UIStatusBarStyle {
//            .lightContent
//        }
//    }
}
