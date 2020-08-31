//
//  RecipeViewContainerProtocol.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

protocol RecipeViewContainerProtocol {
    var recipe:            Recipe! { get set }
    var isInEditMode:      Bool { get set }
    var hasUnsavedChanges: Bool { get }
    
    func commitChanges()
}
