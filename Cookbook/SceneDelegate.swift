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
//        addTestRecipes(5)
        
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
    
    private func addTestRecipes(_ number: Int) {
        let context = RecipesStore.shared.persistentContainer.viewContext
        
        for i in 1...number {
            let rec = Recipe(context: context)

            rec.id = UUID().uuidString
            rec.creationDate = Date()
            
            if i == 1 || i == 4 {
                rec.image = UIImage(named: "Cake1")?.jpegData(compressionQuality: 1)
            } else if i == 2 || i == 5 {
                rec.image = UIImage(named: "Cake2")?.jpegData(compressionQuality: 1)
            }

            rec.title = "Strawberry Cake"//"Chocolate Cake"
            rec.portions = 5

            rec.worktime = 45
            rec.resttime = 15

//            rec.ingredients =
//            """
//            - Chocolate
//            - Famine
//            - Egss
//            - Milk
//            - Sugar
//            """
//            rec.instructions =
//            """
//            1. Put together
//            2. Bake
//            3. Eat and enjoy!
//            """

            try! context.save()
        }
    }
    
    
    
    // MARK: - Change status bar style
    class ContentHostingController<T: View>: UIHostingController<T> {
        override var preferredStatusBarStyle: UIStatusBarStyle {
            .lightContent
        }
    }
}


