//
//  DurationView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

struct DurationView: View {
    
    @ObservedObject var recipe: Recipe
    
    @Environment(\.editMode) var editMode
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.geometryProxy) var geo
    
    @Binding var worktime: String
    @Binding var resttime: String
    
    
    
    private var worktimeLabel: some View {
        Group {
            Text("Work time: ") + Text("\(Int(exactly: recipe.worktime) ?? 0)") + Text(" min")
        }
        .foregroundColor(.gray)
        .font(.footnote)
    }
    
    private var resttimeLabel: some View {
        Group {
            Text("Rest time: ") + Text("\(Int(exactly: recipe.resttime) ?? 0)") + Text(" min")
        }
        .foregroundColor(.gray)
        .font(.footnote)
    }
    
    private var worktimeField: some View {
        HStack {
            Text("Work time: ")
            TextField("0", text: $worktime)
                .frame(width: 50)
                .keyboardType(.asciiCapableNumberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("min")
        }
        .layoutPriority(1)
    }
    
    private var resttimeField: some View {
        HStack {
            Text("Rest time: ")
            TextField("0", text: $resttime)
                .frame(width: 50)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("min")
        }
        .layoutPriority(1)
    }
    
    var body: some View {
        Group {
            if sizeClass! == .compact {
                HStack {
                    VStack(alignment: .leading) {
                        if editMode?.wrappedValue == .inactive {
                            worktimeLabel
                            resttimeLabel
                        }
                        else {
                            worktimeField
                            resttimeField
                        }
                    }
                    
                    Spacer()
                }
            }
            else {
                HStack {
                    Spacer()
                    if editMode?.wrappedValue == .inactive {
                        worktimeLabel
                        Spacer()
                        resttimeLabel
                    }
                    else {
                        worktimeField
                        Spacer()
                        resttimeField
                    }
                    Spacer()
                }
            }
        }
        .frame(width: geo!.size.width - 32)
    }
}
