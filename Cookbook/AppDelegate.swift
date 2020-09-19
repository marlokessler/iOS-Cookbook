//
//  AppDelegate.swift
//  Cookbook
//
//  Created by Marlo Kessler on 07.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AppVersioner.initialize()
        SettingsConnector.initialize()
        SpotlightIndexer.initialize()
        
//        TestRecipes.chocolateCake_en()
//        TestRecipes.smoothie_en()
//        TestRecipes.salad_en()
//        TestRecipes.lemonade_en()
//        TestRecipes.sandwich_en()
//        TestRecipes.burger_en()
//        TestRecipes.muffins_en()
//        TestRecipes.lasagne_en()
//        TestRecipes.bowl_en()
//        TestRecipes.chiliConCarne_en()
        
        // Set-up UI
        setNavBarAppearence()
        return true
    }
    
    private func setNavBarAppearence() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.backgroundAccent
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        UINavigationBar.appearance().tintColor = .white
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        NSLog("RECEIVED IN APP")
        return true
    }
}

