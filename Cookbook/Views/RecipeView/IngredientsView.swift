//
//  IngredientsView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI
import SwiftUIViews

struct IngredientsView: View {
    
    
    
    @ObservedObject var recipe: Recipe
    
    @Binding var ingredients: String
    
    @Environment(\.editMode) var editMode
    @Environment(\.geometryProxy) var geo
    
    private var width: CGFloat {
        (geo!.size.width > 720 ? 720 : geo!.size.width) - 32
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title)
                .fontWeight(.semibold)
            
            if self.editMode?.wrappedValue == .inactive {
                self.recipe.ingredients.map(Text.init)?
                    .fixedSize(horizontal: false, vertical: true)
                
                // Sizes the VStack properly
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: width, height: 0)
            }
            else {
                TextView(self.$ingredients)
                    .placeholder("Ingredients")
                    .textFieldStyle(.roundedBorders())
                    .font(.systemFont(ofSize: 12))
                    .frame(width: width, height: 300)
            }
        }
        .frame(width: width)
    }
}
