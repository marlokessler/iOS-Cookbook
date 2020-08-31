//
//  ImageView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

//import SwiftUI
//import SwiftUIViews
//
//struct ImageView: View {
//    
//    
//    
//    init(_ recipe: Recipe, newImage: Binding<UIImage?>) {
//        self.recipe = recipe
//        self._newImage = newImage
//    }
//    
//    
//    
//    @ObservedObject var recipe: Recipe
//    
//    @Binding var newImage: UIImage?
//    
//    @Environment(\.horizontalSizeClass) var sizeClass
//    @Environment(\.editMode) var editMode
//    @Environment(\.geometryProxy) var geo
//    
//    @State var showImagePicker = false
//    
//    private var width: CGFloat {
//        (geo!.size.width > 720 ? 720 : geo!.size.width) - 32
//    }
//    
//    private var height: CGFloat? {
//        editMode?.wrappedValue == .inactive && newImage == nil && recipe.image == nil ? -16 : nil
//    }
//    
//    private var image: UIImage {
//        return newImage ?? UIImage(data: self.recipe.image!) ?? UIImage()
//    }
//    
//    private var showEditImageButton: Bool {
//        self.editMode?.wrappedValue != .inactive && (self.recipe.image != nil || newImage != nil)
//    }
//    
//    
//    
//    var body: some View {
//        VStack {
//            if editMode?.wrappedValue != .inactive && newImage == nil && recipe.image == nil {
//                Rectangle()
//                    .frame(width: width, height: width * 3/4)
//                    .foregroundColor(.primaryAccent)
//                    .overlay(Text("Add Image").foregroundColor(.white).bold())
//                    .cornerRadius(20)
//                    .clipped()
//                    .hoverEffect()
//                    .onTapGesture { self.showImagePicker.toggle() }
//            }
//            else if newImage == nil || recipe.image == nil {
//                Image(uiImage: newImage ?? UIImage(data: self.recipe.image ?? Data()) ?? UIImage())
//                    .resizable()
//                    .scaledToFill()
//                    .clipped()
//                    .frame(width: width, height: width * 3/4)
//                    .cornerRadius(20)
//                    .padding(.bottom, showEditImageButton ? 8 : 0)
//                    .onTapGesture {
//                        if self.editMode?.wrappedValue != .inactive {
//                            self.showImagePicker.toggle()
//                        }
//                    }
//            }
//            
//            if showEditImageButton {
//                VStack {
//                    Spacer()
//                    Text("Edit Image")
//                        .foregroundColor(.white)
//                        .padding(.vertical, 4)
//                        .padding(.horizontal)
//                        .background(Color.primaryAccent)
//                        .cornerRadius(20)
//                }
//                .hoverEffect()
//                .onTapGesture { self.showImagePicker.toggle() }
//            }
//            
//        }
//        .frame(width: width, height: height)
//        .frame(maxWidth: 720)
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: self.$newImage)
//                .allowEditing(true)
//                .foregroundColor(.primaryAccent)
//        }
//    }
//}
