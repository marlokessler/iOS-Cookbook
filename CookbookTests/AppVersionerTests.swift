//
//  AppVersionerTests.swift
//  CookbookTests
//
//  Created by Marlo Kessler on 07.10.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import XCTest
@testable import Cookbook
import Firebase

class AppVersionerTests: XCTestCase {

    let testedVersion: AppVersioner.Version = .v1_0_0
    
    override func setUpWithError() throws {
        let defaults = UserDefaults(suiteName: "Versioner")
        let defaultsVersionKey = "StoredAppVersion"
        defaults?.set(testedVersion.rawValue, forKey: defaultsVersionKey)
    }

    func checkCurrentVersion() throws {
        XCTAssert(AppVersioner.shared.currentVersion == testedVersion)
    }
    
    func checkPreviousVersion() throws {
        XCTAssert(AppVersioner.shared.previousVersion == testedVersion)
    }
}
