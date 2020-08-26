//
//  RecipeExtensions.swift
//  Cookbook
//
//  Created by Marlo Kessler on 21.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

extension Recipe {
    var duration: TimeInterval { worktime + resttime }
}
