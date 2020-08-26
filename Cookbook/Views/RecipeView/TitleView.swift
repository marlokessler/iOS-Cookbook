//
//  TitleView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    
    
    @ObservedObject var recipe: Recipe
    
    @Binding var title: String
    
    @Environment(\.editMode) var editMode
    @Environment(\.geometryProxy) var geo
    
    
    private var width: CGFloat {
        (geo!.size.width > 720 ? 720 : geo!.size.width) - 32
    }
    
    
    var body: some View {
        HStack {
            if self.editMode?.wrappedValue == .inactive {
                self.recipe.title.map(Text.init)?
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            } else {
                TextField("Title", text: self.$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: width)
            }
        }
        .frame(width: width)
    }
}
