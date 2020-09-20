//
//  FeaturesViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 05.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import WhatsNewKit
import UIKit

class FeaturesViewController {
    private init() {}
    
    static func instantiate() -> WhatsNewViewController? {
        if let storedAppVersion = storedAppVersion {
            let whatsNewViewController = getFeaturesViewController(with: storedAppVersion)
            return whatsNewViewController
        } else {
            setCurrentAppVersion()
            return introViewController
        }
        
    }
    
    private static var storedAppVersion: String? {
        return UserDefaults(suiteName: "WhatsNewVC")?.string(forKey: "AppVersion")
    }
    
    private static var currentAppVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    private static func setCurrentAppVersion() {
        guard
            let currentAppVersion = currentAppVersion,
            let defaults = UserDefaults(suiteName: "WhatsNewVC")
        else { return }
        
        defaults.set(currentAppVersion, forKey: "AppVersion")
    }
    
    private static func getFeaturesViewController(with storedAppVersion: String) -> WhatsNewViewController? {
        guard
            let currentAppVersion = currentAppVersion,
            currentAppVersion != storedAppVersion,
            let whatsNewVC = createWhatsNewVC(for: currentAppVersion)
        else { return nil }
        setCurrentAppVersion()
        return whatsNewVC
    }
    
    private static func createWhatsNewVC(for appVersion: String) -> WhatsNewViewController? {
        let whatsNewItems: [WhatsNew.Item]
        
        switch currentAppVersion {
        case "1.1.0": whatsNewItems = whatsNewInVersion_1_1_0
        default: return nil
        }
        
        let whatsNew = WhatsNew(title: "What's new".localized(),
                                items: whatsNewItems)
        return WhatsNewViewController(whatsNew: whatsNew, configuration: baseConfiguration)
    }
    
    private static var baseConfiguration: WhatsNewViewController.Configuration {
        var configuration = WhatsNewViewController.Configuration()
        configuration.backgroundColor = .background
        
        configuration.titleView.titleColor = .introScreenPrimary
        configuration.titleView.titleMode  = .scrolls
        
        configuration.itemsView.titleFont  = .systemFont(ofSize: 20, weight: .semibold)
        configuration.itemsView.titleColor = .introScreenPrimary
        configuration.itemsView.layout     = .left
        
        configuration.completionButton.backgroundColor = UIColor(named: "IntroScreenInverted") ?? .purple
        configuration.completionButton.titleColor      = .white
        configuration.completionButton.hapticFeedback  = .impact(.medium)
        configuration.completionButton.title           = "Let's start!".localized()        
        
        configuration.apply(animation: .slideUp)
        
        return configuration
    }
    
    
    
    // MARK: - Intro
    private static var introViewController: WhatsNewViewController {
        let whatsNew = WhatsNew(title: "Welcome to Cookbook".localized(),
                                items: whatsNewInVersion_1_0_0 +
                                       whatsNewInVersion_1_1_0
                       )
        return WhatsNewViewController(whatsNew: whatsNew, configuration: baseConfiguration)
    }
    
    
    
    // MARK: - 1.0.0
    private static var whatsNewInVersion_1_0_0: [WhatsNew.Item] {
        return [
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
    }
    
    
    
    // MARK: - 1.1.0
    private static var whatsNewInVersion_1_1_0: [WhatsNew.Item] {
        return [
            WhatsNew.Item(
                title: "Search your favorite Recipes in Spotlight".localized(),
                subtitle: "All your recipes are only one tap away. You can search for all of them in Spotlight 🔎".localized(),
                image: nil
            )
        ]
    }
}
