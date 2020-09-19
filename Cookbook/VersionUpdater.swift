//
//  Versioner.swift
//  Cookbook
//
//  Created by Marlo Kessler on 19.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

class Versioner {
    
    private init() {}
    
    static func initialize() {
        prepareForVersioning()
        update()
    }
    
    private static func update() {
        switch oldVersion {
        case "1.0.0": updateTo_1_1_0()
        default: return
        }
    }
    
    
    private static let defaults = UserDefaults(suiteName: "VersionUpdater")
    private static var oldVersion: String { defaults?.string(forKey: updatedDefaultsKey) ?? "" }
    private static let updatedDefaultsKey = "UpdatedToVersion"
    
    private static func updateTo_1_1_0() {
        defaults?.set(true, forKey: "UpdatedToVersion")
        let receiptStore = RecipesStore.shared
        
        for receipt in receiptStore.values {
            receipt.id = UUID().uuidString
            receipt.creationDate = Date()
            receiptStore.update(receipt)
        }
    }
    
    private static func prepareForVersioning() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if appVersion == "1.1.0" {
            defaults?.set("1.0.0", forKey: updatedDefaultsKey)
        }
    }
}
