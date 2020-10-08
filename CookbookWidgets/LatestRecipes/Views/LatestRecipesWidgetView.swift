//
//  LatestRecipesWidgetView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI
import WidgetKit

struct LatestRecipesWidgetView : View {
    
    var container: RecipesWidgetDataContainer
    
    @Environment(\.widgetFamily) private var widgetFamily
    
    private var maxIndex: Int {
        switch widgetFamily {
        case .systemLarge: return 1
        default: return 0
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader{ geo in
                VStack(spacing: 8) {
                    if self.container.recipes.isEmpty {
                        AddRecipeView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        ForEach(0...self.maxIndex, id: \.self) { index in
                            if index < self.container.recipes.count {
                                RecipeCellView(recipe: self.container.recipes[index])
                                    .cornerRadius(20)
                            } else {
                                Rectangle()
                                    .frame(width: geo.size.width, height: geo.size.height/2)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                }
            }.padding(widgetFamily == .systemLarge ? 8 : 0)
        }
        .background(Color.background)
    }
}



struct LatestRecipesWidgetView_Previews: PreviewProvider {
    private static var previewRecipesData = [RecipeData(title: "Chocolate Cake", image: UIImage(named: "Chocolate Cake") ?? UIImage(), duration: 120)]
    private static var previewRecipesContainer = RecipesWidgetDataContainer(recipes: previewRecipesData)
    
    static var previews: some View {
        Group {
            LatestRecipesWidgetView(container: previewRecipesContainer)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            LatestRecipesWidgetView(container: previewRecipesContainer)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            LatestRecipesWidgetView(container: previewRecipesContainer)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
