//
//  RecipeCellView.swift
//  CookbookWidgetsExtension
//
//  Created by Marlo Kessler on 24.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

struct RecipeCellView: View {
    
    var recipe: RecipeData
    
    @Environment(\.widgetFamily) private var widgetFamily
    
    var body: some View {
        WidgetLink(destination: URL(string: "openrecipe://\(recipe.id)")!) {
            VStack {
                Spacer()
                
                HStack {
                    recipe.title.map(Text.init)
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if widgetFamily != .systemSmall {
                        Text("\(Int(exactly: recipe.duration) ?? 0) min")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(Color.introScreenInverted.opacity(0.6))
            }
            .background(
                Group {
                    if let image = recipe.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    } else {
                        Color.introScreenInverted
                    }
                }
            )
        }
    }
}
