//
//  RecipesWidgetDataContainer.swift
//  CookbookWidgetsExtension
//
//  Created by Marlo Kessler on 23.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import WidgetKit

struct RecipesWidgetDataContainer: TimelineEntry {
    let recipes: [RecipeData]
    let date = Date()
}
