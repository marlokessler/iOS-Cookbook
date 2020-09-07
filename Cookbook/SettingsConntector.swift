//
//  SettingsConntector.swift
//  Cookbook
//
//  Created by Marlo Kessler on 07.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

class SettingsConnector {
    
    private init() {}
    
    /// Sets the settings in the Settings app asyncronousely.
    static func initialize() {
        DispatchQueue.global(qos: .background).async {
            setAppVersion()
        }
    }
    
    private static func setAppVersion() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        UserDefaults.standard.set(appVersion, forKey: "AppVersion")
    }
}
