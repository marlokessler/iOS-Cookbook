//
//  NewRecipeContainerView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 23.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

//import SwiftUI
//
//// It is necessary to wrap the RecipeView in an container for a new recipe, where a new Recipe object is only created when the view appears, because otherwise a memory and cpu overflow occures (maybe a bug).
//struct NewRecipeContainerView: View {
//    
//    
//    
//    @Environment(\.managedObjectContext) var managedObjectContext
//    
//    @State private var didAppear = false
//    
//    
//    
//    var body: some View {
//        Group {
//            if didAppear {
//                RecipeView(Recipe(context: managedObjectContext), isNew: true)
//            }
//        }
//        .onAppear {
//            self.didAppear = true
//        }
//    }
//}
//
//struct NewRecipeContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRecipeContainerView()
//    }
//}
