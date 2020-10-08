//
//  LatestRecipesProvider.swift
//  CookbookWidgetsExtension
//
//  Created by Marlo Kessler on 23.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit
import WidgetKit

struct LatestRecipesProvider: TimelineProvider {
    
    typealias Entry = RecipesWidgetDataContainer

    func placeholder(in context: Context) -> Entry {
        let dummyData = RecipeData(id: "id", title: "Title", image: nil, duration: 0)
        return RecipesWidgetDataContainer(recipes: [dummyData])
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        getRecipesWidgetDataContainer { container in
            completion(container)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {        
        getRecipesWidgetDataContainer { container in
            let timeline = Timeline(entries: [container], policy: .never)
            completion(timeline)
        }
    }
    
    private func getRecipesWidgetDataContainer(completion: @escaping (RecipesWidgetDataContainer) -> Void) {
        RecipesStore.fetchRecipesData { data in
            guard let data = data else {
                let dummyContainer = RecipesWidgetDataContainer(recipes: [RecipeData()])
                completion(dummyContainer)
                return
            }
            let container = RecipesWidgetDataContainer(recipes: data)
            completion(container)
        }
    }
}
