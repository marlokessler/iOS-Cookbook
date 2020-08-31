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
//            if !UserDefaults().bool(forKey: "IntroScreenShown") {
//                showIntroScreen()
//            }
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
    
    private func showIntroScreen() {
        
        // Intro
        let intro = WhatsNew(
            // The Title
            title: "Welcome to Cookbook",
            // The features you want to showcase
            items: [
                WhatsNew.Item(
                    title: "Store your favorite recipes",
                    subtitle: "You can easily store all your favorite recipes in Cookbook 🥘🥗🧁",
                    image: nil
                ),
                WhatsNew.Item(
                    title: "Access your recipes",
                    subtitle: "You can easily access your recipes when you need them and cook some magic 👩🏼‍🍳👨🏿‍🍳",
                    image: nil
                )
            ]
        )
        
        
        
        // Config
        var configuration = WhatsNewViewController.Configuration()
        configuration.backgroundColor = .background
        
        configuration.titleView.titleColor = .introScreenPrimary
        
        configuration.itemsView.titleFont = .systemFont(ofSize: 20, weight: .semibold)
        configuration.itemsView.titleColor = .introScreenPrimary
        
        configuration.completionButton.backgroundColor = UIColor(named: "IntroScreenInverted") ?? .purple
        configuration.completionButton.titleColor = .white
        configuration.completionButton.hapticFeedback = .impact(.medium)
        configuration.completionButton.title = "Let's start!"
        
        configuration.itemsView.layout = .left
        
        configuration.apply(animation: .slideUp)
                
        let introViewController = WhatsNewViewController(whatsNew: intro, configuration: configuration)
        
        
        
        // Present
        guard let parentController = window?.rootViewController else { return }
        parentController.present(introViewController, animated: true)
        
        // Set marker that intro screen has been shown
        UserDefaults().set(true, forKey: "IntroScreenShown")
    }
    
    
    
    // MARK: - Change status bar style
    class ContentHostingController<T: View>: UIHostingController<T> {
        override var preferredStatusBarStyle: UIStatusBarStyle {
            .lightContent
        }
    }
}


