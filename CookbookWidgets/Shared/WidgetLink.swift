//
//  WidgetLink.swift
//  CookbookWidgetsExtension
//
//  Created by Marlo Kessler on 24.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

struct WidgetLink<Content: View>: View {
    
    init(destination url: URL, @ViewBuilder content: @escaping () -> Content) {
        self.url = url
        self.content = content
    }
    
    private let url: URL
    private let content: () -> Content
    
    var body: some View {
        Link(destination: url, label: content).widgetURL(url)
    }
}
