//
//  RecipeView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 07.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI
import SwiftUIViews

struct RecipeView: View {
    
    init(_ recipe: Recipe, isNew: Bool = false) {
        self.recipe = recipe
        self.isNew = isNew
    }
        
    // MARK: - Variables
    var isNew: Bool
    
    @ObservedObject var recipe: Recipe
    @ObservedObject var keyboard = Keyboard.shared
    
    @Environment(\.managedObjectContext) var managedContext
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode

    @State var editMode: EditMode = .inactive
    @State var showCancelAlert = false
    @State var keyboardHeight: CGFloat = 0

    @State var newImage: UIImage?
    @State var title        = ""
    @State var worktime     = ""
    @State var resttime     = ""
    @State var ingredients  = ""
    @State var instructions = ""
    
    

    // MARK: - Methods

    func prepareForEditing() {
        newImage     = nil
        title        = recipe.title ?? ""
        worktime     = "\(recipe.worktime)"
        resttime     = "\(recipe.resttime)"
        ingredients  = recipe.ingredients ?? ""
        instructions = recipe.instructions ?? ""
    }

    var didChange: Bool {
           newImage     != nil
        || title        != recipe.title ?? ""
        || worktime     != "\(recipe.worktime)"
        || resttime     != "\(recipe.resttime)"
        || ingredients  != recipe.ingredients ?? ""
        || instructions != recipe.instructions ?? ""
    }

    func save() {
        if didChange {
            if let image = newImage {
                recipe.image = image.jpegData(compressionQuality: 1)
            }

            recipe.title = title

            recipe.worktime = TimeInterval(worktime) ?? 0
            recipe.resttime = TimeInterval(worktime) ?? 0

            recipe.ingredients = ingredients
            recipe.instructions = instructions

            do {
                try managedContext.save()
            } catch {
                print("Error in RecipeView: \(error)")
            }
        }

        editMode = .inactive
    }

    func cancel() {
        if isNew {
            managedContext.delete(recipe)
            presentationMode.wrappedValue.dismiss()
        } else {
            self.editMode = .inactive
        }
    }
    
    private func width(for geo: GeometryProxy) -> CGFloat {
        (geo.size.width > 720 ? 720 : geo.size.width) - 32
    }
    
    
    
    // MARK: - View
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    VStack {
                        
                        ImageView(self.recipe, newImage: self.$newImage)
                        
                        Group {
                            
                            // Title
                            TitleView(recipe: self.recipe, title: self.$title)
                            
                            // Duration
                            if self.sizeClass! == .compact {
                                VStack(alignment: .leading) {
                                    DurationView(recipe: self.recipe, worktime: self.$worktime, resttime: self.$resttime)
                                }
                            }
                            else {
                                HStack {
                                    DurationView(recipe: self.recipe, worktime: self.$worktime, resttime: self.$resttime)
                                }
                            }
                            
                            Divider().frame(width: self.width(for: geo))
                            
                            // Ingredients
                            IngredientsView(recipe: self.recipe, ingredients: self.$ingredients)
                            
                            
                            Divider().frame(width: self.width(for: geo))
                            
                            // Instructions
                            InstructionView(recipe: self.recipe, instructions: self.$instructions)
                                .layoutPriority(0)
                        }
                        .padding(.vertical, 4)
                        
                        Rectangle().foregroundColor(.clear).frame(height: self.keyboard.height)
                    }
                    .frame(width: geo.size.width - 32)
                    .frame(maxWidth: 720)
                    .padding(.vertical)
                    .environment(\.editMode, self.$editMode)
                    .environment(\.geometryProxy, geo)
                }
                .frame(width: geo.size.width)
            }
        }
        .background(Color.background)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading:
            HStack {
                if self.editMode == .inactive {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                    }
                    .hoverEffect()
                }
                else {
                    Button(action: {
                        if self.didChange {
                            self.showCancelAlert.toggle()
                        }
                        else {
                            self.cancel()
                        }
                    }) {
                        Text("Cancel")
                    }
                    .hoverEffect()
                }
            }
            , trailing:
            Button(action: {
                if self.editMode == .inactive {
                    self.prepareForEditing()
                    self.editMode = .active
                }
                else {
                    self.save()
                }
            }) {
                Text(self.editMode == .inactive ? "Edit" : "Save")
            }
            .hoverEffect()
        )
        .alert(isPresented: $showCancelAlert) {
            Alert(title: Text(self.isNew
                                ? "Are your sure you want to discard this new recipe?"
                                : "Are your sure you want to discard your changes?"),
                                  primaryButton: .destructive(Text("Discard Changes"), action: { self.cancel() }),
                                  secondaryButton: .cancel(Text("Keep Editing")))
        }
        .onAppear {
            self.editMode = self.isNew ? .active : .inactive
        }
    }
}
