//
//  RecipeWidgetData.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import WidgetKit
import UIKit

struct RecipeWidgetData: TimelineEntry {
    let image: UIImage?
    let title: String?
    var duration: String { "" }
    
    init(with recipe: Recipe) {
        image =
    }
    
    let date = Date()
}
