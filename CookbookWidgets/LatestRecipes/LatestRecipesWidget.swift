//
//  LatestRecipesWidget.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import WidgetKit
import SwiftUI

struct LatestRecipesWidget: Widget {
    let kind: String = "LatestRecipesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LatestRecipesProvider()) { container in
            LatestRecipesWidgetView(container: container)
        }
        .configurationDisplayName("Latest Recipes")
        .description("View your latest recipes at a glance.")
    }
}
