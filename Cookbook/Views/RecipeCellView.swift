//
//  RecipeCellView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 07.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

struct RecipeCellView: View {
    
    
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    
    
    @ObservedObject var recipe: Recipe
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.editMode) var editMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.geometryProxy) var geo
    
    @State var isActive = false
    
    private var image: UIImage {
        UIImage(data: self.recipe.image ?? Data()) ?? UIImage()
    }
    
    
    
    // MARK: - Views
    var body: some View {
        VStack {
            ZStack {
                
                NavigationLink(destination: RecipeView(recipe), isActive: $isActive) {
                    EmptyView()
                }
                .hidden()
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: .infinity)
                    .cornerRadius(20)
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        self.recipe.title.map(Text.init)?
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .lineLimit(3)
                            .layoutPriority(1)
                            .padding()
                        
                        Spacer().frame(height: 0)
                        
                        Text("\(Int(exactly: recipe.duration) ?? 0) min")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .layoutPriority(2)
                            .padding()
                    }
                    .background(
                        Image(uiImage: image)
                            .resizable()
                            .blur(radius: 20, opaque: true)
                            .clipped()
                    )
                    .frame(width: geo!.size.width)
                }
            }
            .frame(width: geo!.size.width, height: geo!.size.height)
            .background(Color.backgroundAccent)
            .cornerRadius(20)
            .shadow(radius: colorScheme == .dark ? 0 : 5)
            .hoverEffect()
            .onTapGesture {
                #if DEBUG
                print("Should open RecipeView for: \(self.recipe.title ?? "Not title")")
                #endif
                if self.editMode?.wrappedValue == .inactive {
                    self.isActive = true
                }
            }
        }
    }
}
