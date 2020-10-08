//
//  AddRecipeView.swift
//  CookbookWidgetsExtension
//
//  Created by Marlo Kessler on 24.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

struct AddRecipeView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            WidgetLink(destination: URL(string: "createrecipe://")!) {
                Text("Add Recipe")
                    .foregroundColor(.primaryAccent)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding()
            }
            Spacer()
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
