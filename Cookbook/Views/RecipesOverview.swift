//
//  RecipesOverview.swift
//  Cookbook
//
//  Created by Marlo Kessler on 07.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI
import ASCollectionView
import CoreData

struct RecipesOverview: View {
    
    
    
    // MARK: - Variables
    @FetchRequest(
      entity: Recipe.entity(),
      sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.title, ascending: true)]
    ) var recipes: FetchedResults<Recipe>

    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var editMode: EditMode = .inactive
    @State var showNewRecipeView  = false
    @State var showDeletationAlert = false
    @State var showDeletationErrorAlert = false
    @State var deleteRecipeIndex = -1
    
    private var layout: ASCollectionLayoutSection {
        return UIDevice().userInterfaceIdiom == .phone
                ? .orthogonalGrid(
                    gridSize: 1,
                    itemDimension: .fractionalWidth(0.9),
                    sectionDimension: .fractionalHeight(0.98),
                    orthogonalScrollingBehavior: .groupPagingCentered,
                    itemInsets: NSDirectionalEdgeInsets(top: 32, leading: 8, bottom: 32, trailing: 8)
                )
                : .grid(
                        layoutMode: .adaptive(withMinItemSize: 300),
                        itemSpacing: 50,
                        lineSpacing: 50,
                        itemSize: .estimated(400)
                )
    }
    
    
    
    // MARK: - Methods
    private func addRecipe() {
        editMode = .inactive
        self.showNewRecipeView = true
    }
    
    private func deleteRecipe() {
        
        #if DEBUG
        print("Deletation inited for \(deleteRecipeIndex)")
        #endif
        
        if deleteRecipeIndex >= 0 && deleteRecipeIndex < recipes.count {
            print("Delete")
            self.managedObjectContext.delete(recipes[deleteRecipeIndex])
            
            do {
                try managedObjectContext.save()
            } catch {
                #if DEBUG
                print("Deletation failed")
                #endif
            }
        }
        
        deleteRecipeIndex = -1
    }
    
    
    
    // MARK: - View
    private var sections: [ASSection<SectionID>] {
        [
            ASSection(id: SectionID.recipes, data: recipes, dataID: \.id, contentBuilder: { recipe, cellContext in
                GeometryReader { geo in
                    CellContainer(recipe: recipe)
                        .environment(\.editMode, self.$editMode)
                        .environment(\.geometryProxy, geo)
                        
                        // MARK: Delete recipe button
                        .overlay(
                            Group {
                                if self.editMode != .inactive {
                                    Button(action: {
                                        self.deleteRecipeIndex = cellContext.index
                                        self.showDeletationAlert.toggle()
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.red)
                                            .background(Circle().foregroundColor(.white))
                                    }
                                    .position(x: geo.size.width - 5, y: 4 + 5)
                                }
                            }
                        )
                }
            })
        ]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !self.recipes.isEmpty {
                    ASCollectionView(sections: self.sections)
                        .layout { self.layout }
                        .padding(.top)
                        .shadow(radius: 5)
                        
                }
                
                NavigationLink(destination: NewRecipeContainerView(), isActive: self.$showNewRecipeView) {
                    EmptyView()
                }
                .hidden()
            }
            .background(Color.background.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("My Recipes")
            .navigationBarItems(trailing: HStack {
                EditButton()
                    .hoverEffect()
                    .environment(\.editMode, self.$editMode)

                Button(action: {
                    self.addRecipe()
                }) {
                    Image(systemName: "plus")
                }
                .hoverEffect()
            })
        }
        .animation(.default)
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.editMode, $editMode)
        .accentColor(.primaryAccent)
        .alert(isPresented: $showDeletationAlert) {
            Alert(title: Text("Do you want to delete this recipe?"),
                  primaryButton: .destructive(Text("Delete Recipe"), action: { print("Delete Recipe");self.deleteRecipe() }),
                  secondaryButton: .cancel { self.deleteRecipeIndex = -1 })
        }
    }
    
    
    // MARK: - SectionIDs
    private enum SectionID: Hashable {
        case recipes
    }
}



// MARK: - Preview
struct RecipesOverview_Previews: PreviewProvider {
    static var previews: some View {
        RecipesOverview()
    }
}
