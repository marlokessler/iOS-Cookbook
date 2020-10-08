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
        let appVersioner = AppVersioner.shared
        guard appVersioner.appHasNewVersion,
              let newVersion = appVersioner.currentVersion,
              let previousVersion = appVersioner.previousVersion else { return nil }
        
        let whatsNewViewController = createWhatsNewVC(from: previousVersion, to: newVersion)
        return whatsNewViewController
    }
    
    private static func createWhatsNewVC(from previousVersion: AppVersioner.Version, to currentVersion: AppVersioner.Version) -> WhatsNewViewController? {
        let whatsNewItems = getWhatsNewItems(from: previousVersion, to: currentVersion)
        guard !whatsNewItems.isEmpty else { return nil }
        
        let whatsNew = WhatsNew(title: (appDidLaunchBefore ? "Welcome to Cookbook" : "What's new").localized(), items: whatsNewItems)
        return WhatsNewViewController(whatsNew: whatsNew, configuration: baseConfiguration)
    }
    
    private static var appDidLaunchBefore: Bool {
        return AppVersioner.shared.currentVersion ?? .v1_0_0 > .v1_0_0
    }
    
    private static func getWhatsNewItems(from startVersion: AppVersioner.Version, to endVersion: AppVersioner.Version) -> [WhatsNew.Item] {
        var items = [WhatsNew.Item]()
        var currentVersion = startVersion
        
        while currentVersion <= endVersion {
            let newItems = getWhatsNewItems(for: currentVersion)
            items.append(contentsOf: newItems)
            
            guard let followingVersion = currentVersion.followingVersion else { break }
            currentVersion = followingVersion
        }
        
        return items
    }
    
    private static func getWhatsNewItems(for version: AppVersioner.Version) -> [WhatsNew.Item] {
        switch version {
        case .v1_0_0: return whatsNewInVersion_1_0_0
        case .v1_1_0: return whatsNewInVersion_1_1_0
        case .v1_2_0: return whatsNewInVersion_1_2_0
        }
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
    
    
    
    // MARK: - 1.0.0
    private static var whatsNewInVersion_1_0_0: [WhatsNew.Item] {
        return [
            WhatsNew.Item(
                title: "Store your recipes".localized(),
                subtitle: "You can easily store all your favorite recipes in Cookbook 🥘🥗🧁".localized(),
                image: UIImage(systemName: "book")
            ),
            WhatsNew.Item(
                title: "Access your recipes".localized(),
                subtitle: "You can easily access your recipes when you need them and cook some magic 👩🏼‍🍳👨🏿‍🍳".localized(),
                image: UIImage(systemName: "wand.and.stars")
            )
        ]
    }
    
    
    
    // MARK: - 1.1.0
    private static var whatsNewInVersion_1_1_0: [WhatsNew.Item] {
        return [
            WhatsNew.Item(
                title: "Spotlight Search".localized(),
                subtitle: "All your recipes are only one tap away. You can search for all of them in Spotlight 🔎".localized(),
                image: UIImage(systemName: "magnifyingglass")
            )
        ]
    }
    
    
    
    // MARK: - 1.2.0
    private static var whatsNewInVersion_1_2_0: [WhatsNew.Item] {
        if #available(iOS 14.0, *) {
            return [
                WhatsNew.Item(
                    title: "Widget Support".localized(),
                    subtitle: "View your latest recipes in widgets on your home screen📱".localized(),
                    image: UIImage(systemName: "rectangle.3.offgrid")
                )
            ]
        } else {
            return []
        }
    }
}
