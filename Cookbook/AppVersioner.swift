//
//  AppVersioner.swift
//  Cookbook
//
//  Created by Marlo Kessler on 19.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

class AppVersioner {
    
    private init() {}
    
    static func initialize() {
        prepareForVersionability()
        updateVersion()
    }
    
    
    
    private static let defaults = UserDefaults(suiteName: "Versioner")
    private static var oldVersion: String { defaults?.string(forKey: updatedVersionDefaultsKey) ?? "" }
    private static let updatedVersionDefaultsKey = "UpdatedToVersion"
    
    
    
    private static func prepareForVersionability() {
        if oldVersion == "" {
            defaults?.set("1.0.0", forKey: updatedVersionDefaultsKey)
        }
    }
    
    private static func updateVersion() {
        switch oldVersion {
        case "1.0.0":
            updateTo_1_1_0()
        default: return
        }
        updateVersion()
    }
    
    // MARK: - 1.1.0
    // Updates: There is no id and creationDate set with any recipes. Those will be set.
    private static func updateTo_1_1_0() {
        let receiptStore = RecipesStore.shared
        
        for receipt in receiptStore.values {
            receipt.id = UUID().uuidString
            receipt.creationDate = Date()
            receiptStore.update(receipt)
        }
        
        defaults?.set("1.1.0", forKey: updatedVersionDefaultsKey)
    }
}
