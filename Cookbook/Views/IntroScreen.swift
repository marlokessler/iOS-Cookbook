//
//  IntroScreen.swift
//  Cookbook
//
//  Created by Marlo Kessler on 05.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import WhatsNewKit
import UIKit

class Introscreen {
    static func initialize(on viewController: UIViewController) {
        if !UserDefaults().bool(forKey: "IntroScreenShown") {
            present(on: viewController)
            
            // Set marker that intro screen has been shown
            UserDefaults().set(true, forKey: "IntroScreenShown")
        }
    }
    
    private static func present(on viewController: UIViewController) {
        let introViewController = WhatsNewViewController(whatsNew: intro, configuration: configuration)
        viewController.present(introViewController, animated: true)
    }
    
    private static var intro: WhatsNew = {
        WhatsNew(
            // The Title
            title: "Welcome to Cookbook".localized(),
            // The features you want to showcase
            items: [
                WhatsNew.Item(
                    title: "Store your favorite recipes".localized(),
                    subtitle: "You can easily store all your favorite recipes in Cookbook 🥘🥗🧁".localized(),
                    image: nil
                ),
                WhatsNew.Item(
                    title: "Access your recipes".localized(),
                    subtitle: "You can easily access your recipes when you need them and cook some magic 👩🏼‍🍳👨🏿‍🍳".localized(),
                    image: nil
                )
            ]
        )
    }()
    
    private static var configuration: WhatsNewViewController.Configuration = {
        var configuration = WhatsNewViewController.Configuration()
        configuration.backgroundColor = .background
        
        configuration.titleView.titleColor = .introScreenPrimary
        
        configuration.itemsView.titleFont = .systemFont(ofSize: 20, weight: .semibold)
        configuration.itemsView.titleColor = .introScreenPrimary
        
        configuration.completionButton.backgroundColor = UIColor(named: "IntroScreenInverted") ?? .purple
        configuration.completionButton.titleColor = .white
        configuration.completionButton.hapticFeedback = .impact(.medium)
        configuration.completionButton.title = "Let's start!".localized()
        
        configuration.itemsView.layout = .left
        
        configuration.apply(animation: .slideUp)
                
        return configuration
    }()
}
