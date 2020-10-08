//
//  RecipeWidgetData.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

struct RecipeData {
    init(from recipe: Recipe) {
        id = recipe.id!
        image = UIImage(data: recipe.image ?? Data())
        title = recipe.title
        duration = recipe.duration
    }

    init(id: String? = nil, title: String? = nil, image: UIImage? = nil, duration: TimeInterval? = nil) {
        self.id = id ?? UUID().uuidString
        self.image = image
        self.title = title
        self.duration = duration ?? 0
    }
    
    let id: String
    let image: UIImage?
    let title: String?
    var duration: TimeInterval
}
