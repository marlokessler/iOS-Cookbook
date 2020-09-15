//
//  TestRecipes.swift
//  Cookbook
//
//  Created by Marlo Kessler on 08.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class TestRecipes {
    
    private init() {}
    
    private static var store         = RecipesStore.shared
    private static var objectContext = RecipesStore.shared.objectContext
    
    private static func standardRecipe() -> Recipe {
        let recipe = Recipe(context: objectContext)
        recipe.id = UUID().uuidString
        recipe.creationDate = Date()
        return recipe
    }
}



// MARK: - Chocolate Cake
extension TestRecipes {
    private static func chocolateCake_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Chocolate Cake")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func chocolateCake_en() {
        let recipe = chocolateCake_Recipe()
        recipe.title = "Chocolate Cake"
        recipe.portions = 16
        recipe.worktime = 30
        recipe.resttime = 30
        recipe.ingredientsData = [
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "cup butter, softened"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "cups packed brown sugar"],
            [Recipe.IngredientKeys.amount: 4, Recipe.IngredientKeys.description: "large eggs, room temperature"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "teaspoons vanilla extract"],
            [Recipe.IngredientKeys.amount: 2.6, Recipe.IngredientKeys.description: "cups all-purpose flour"],
            [Recipe.IngredientKeys.amount: 0.75, Recipe.IngredientKeys.description: "cup baking cocoa"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "teaspoons baking soda"],
            [Recipe.IngredientKeys.amount: 1.3, Recipe.IngredientKeys.description: "cups sour cream"],
            [Recipe.IngredientKeys.amount: 1.3, Recipe.IngredientKeys.description: "cups boiling water"],
            [Recipe.IngredientKeys.amount: 0.5, Recipe.IngredientKeys.description: "cup butter, cubed"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "ounces unsweetened chocolate, chopped"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "ounces semisweet chocolate, chopped"],
            [Recipe.IngredientKeys.amount: 5, Recipe.IngredientKeys.description: "cups confectioners' sugar"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "cup sour cream"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "teaspoons vanilla extract"]
        ] as [[String : Any]] as NSObject
        
        recipe.instructions = [
            "Preheat oven to 350°. Grease and flour three 9-in. round baking pans.",
            "In a large bowl, cream butter and brown sugar until light and fluffy. Add eggs, 1 at a time, beating well after each addition. Beat in vanilla. In another bowl, whisk flour, cocoa, baking soda and salt; add to creamed mixture alternately with sour cream, beating well after each addition. Stir in water until blended.",
            "Transfer to prepared pans. Bake until a toothpick comes out clean, 30-35 minutes. Cool in pans 10 minutes; remove to wire racks to cool completely.",
            "For frosting, in a metal bowl over simmering water, melt butter and chocolates; stir until smooth. Cool slightly.",
            "In a large bowl, combine confectioners' sugar, sour cream and vanilla. Add chocolate mixture; beat until smooth. Spread frosting between layers and over top and sides of cake. Refrigerate leftovers."
        ] as NSObject
        
        store.add(recipe)
    }
    
    static func chocolateCake_de() {
        let recipe = chocolateCake_Recipe()
        recipe.title = "Schokoladenkuchen"
        recipe.portions = 16
        recipe.worktime = 40
        recipe.resttime = 30
        recipe.ingredientsData = [
            [Recipe.IngredientKeys.amount: 300, Recipe.IngredientKeys.description: "g Butter"],
            [Recipe.IngredientKeys.amount: 8, Recipe.IngredientKeys.description: "El Kakaopulver, (80 g)"],
            [Recipe.IngredientKeys.amount: 350, Recipe.IngredientKeys.description: "g Zucker"],
            [Recipe.IngredientKeys.amount: 250, Recipe.IngredientKeys.description: "g Mehl"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "Tl Natron"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "g Salz"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "Eier, (Kl. M)"],
            [Recipe.IngredientKeys.amount: 150, Recipe.IngredientKeys.description: "g Schmand"],
            [Recipe.IngredientKeys.amount: 60, Recipe.IngredientKeys.description: "ml Milch"],
            [Recipe.IngredientKeys.amount: 200, Recipe.IngredientKeys.description: "g Puderzucker"]
        ] as [[String : Any]] as NSObject
        
        recipe.instructions = [
            "200 g Butter, 4 El Kakaopulver und 200 ml Wasser unter Rühren aufkochen. 10 Min. abkühlen lassen.",
            "Ofen auf 200 Grad (Umluft 180 Grad) vorheizen. Zucker, Mehl, Natron und 1 Prise Salz in einer großen Schüssel mischen. Eier und Schmand zugeben, zusammen mit der Kakaomasse unter die Mehlmischung rühren. In eine gefettete Springform (26 cm Ø) füllen und im heißen Ofen auf dem Rost im unteren Ofendrittel 30 Min. backen.",
            "Inzwischen restliche Butter, restliches Kakaopulver, Milch und Puderzucker unter Rühren aufkochen.",
            "Kuchen auf einem Gitter in der Form lauwarm abkühlen lassen. Mit einem Spieß (z. B. Essstäbchen) mehrmals einstechen, die Hälfte des Gusses darübergießen. Abkühlen lassen. Kuchen mit einem spitzen Messer aus der Form lösen und auf eine Tortenplatte geben. Restlichen Guss erwärmen und als Glasur über den Kuchen gießen."
        ] as NSObject
        
        store.add(recipe)
    }
}



// MARK: - Salad
extension TestRecipes {
    private static func salad_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Salad")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func salad_de() {
        let recipe = salad_Recipe()
        recipe.title = "Römersalat mit Croutons und Parmesan"
        recipe.portions = 4
        recipe.worktime = 30
        recipe.resttime = 0
        recipe.ingredientsData = [
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "Römersalatherzen"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "Vollkorntoast"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "Knoblauchzehen"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "EL Rapsöl"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "TL Zitronenscharf"],
            [Recipe.IngredientKeys.amount: 0.5, Recipe.IngredientKeys.description: "TL scharfer Send"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "Ei"],
            [Recipe.IngredientKeys.amount: 3, Recipe.IngredientKeys.description: "EL Olivenöl"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "g Salz"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "g Pfeffer"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "Msp. Honig"],
            [Recipe.IngredientKeys.amount: 25, Recipe.IngredientKeys.description: "g Parmesan"]
        ] as [[String : Any]] as NSObject
        
        recipe.instructions = [
            "Das Brot nach Belieben entrinden, dann in etwa 1 cm große Würfel schneiden. 2 Knoblauchzehen schälen und fein hacken. Rapsöl in einer Pfanne erhitzen, die Brotwürfel hineingeben und rundherum bei mittlerer Hitze goldbraun rösten. Gegen Ende der Bratzeit den Knoblauch dazugeben. Croutons auf Küchenpapier entfetten.",
            "Den Römersalat putzen, waschen und trocken schleudern. Blätter quer in etwa 2 cm breite Streifen schneiden.",
            "Restlichen Knoblauch, Zitronensaft, Senf, Ei, Olivenöl, Honig, geriebenen Parmesan und ca. 50 ml Wasser in einen Mixbecher geben und miteinander auf höchster Stufe verschlagen, bis das Dressing weiß-cremig ist. Mit Salz und Pfeffer abschmecken, evtl. mit etwas Wasser verdünnen.",
            "Den Römersalat mit dem Dressing mischen und auf tiefe Teller verteilen. Cesar Salat mit Croutons und nach Belieben mit Parmesan garniert servieren."
        ] as NSObject
        
        store.add(recipe)
    }
    
    static func salad_en() {
        let recipe = salad_Recipe()
        recipe.title = "Caesar Salad"
        recipe.portions = 6
        recipe.worktime = 35
        recipe.resttime = 0
        recipe.ingredientsData = [
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "head romaine lettuce, torn into bite-size pieces"],
            [Recipe.IngredientKeys.amount: 5, Recipe.IngredientKeys.description: "anchovies anchovy fillets, minced"],
            [Recipe.IngredientKeys.amount: 100, Recipe.IngredientKeys.description: "g crisp croutons"],
            [Recipe.IngredientKeys.amount: 6, Recipe.IngredientKeys.description: "cloves garlic, peeled, divided"],
            [Recipe.IngredientKeys.amount: 0.75, Recipe.IngredientKeys.description: "cup mayonnaise"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "teaspoon Worcestershire sauce"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "teaspoon Dijon mustard"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "tablespoon lemon juice, or more to taste"],
            [Recipe.IngredientKeys.amount: 0.25, Recipe.IngredientKeys.description: "cup olive oil"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "g salt to taste"],
            [Recipe.IngredientKeys.amount: 1, Recipe.IngredientKeys.description: "g ground black pepper to taste"],
            [Recipe.IngredientKeys.amount: 6, Recipe.IngredientKeys.description: "tablespoons grated Parmesan cheese, divided"]
        ] as [[String : Any]] as NSObject
        
        recipe.instructions = [
            "Mince 3 cloves of garlic, and combine in a small bowl with mayonnaise, anchovies, 2 tablespoons of the Parmesan cheese, Worcestershire sauce, mustard, and lemon juice. Season to taste with salt and black pepper. Refrigerate until ready to use.",
            "Heat oil in a large skillet over medium heat. Cut the remaining 3 cloves of garlic into quarters, and add to hot oil. Cook and stir until brown, and then remove garlic from pan. Add bread cubes to the hot oil. Cook, turning frequently, until lightly browned. Remove bread cubes from oil, and season with salt and pepper.",
            "Place lettuce in a large bowl. Toss with dressing, remaining Parmesan cheese, and seasoned bread cubes."
        ] as NSObject
        
        store.add(recipe)
    }
}



// MARK: - Smoothie
extension TestRecipes {
    private static func smoothie_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Strawberry Smoothie")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func smoothie_en() {
        let recipe = smoothie_Recipe()
        recipe.title = "Strawberry Smoothie"
        recipe.portions = 2
        recipe.worktime = 5
        recipe.resttime = 0
        recipe.ingredientsData = [
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "cups frozen strawberries (unsweetened)"],
            [Recipe.IngredientKeys.amount: 0.5, Recipe.IngredientKeys.description: "cup cranberry-raspberry juice"],
            [Recipe.IngredientKeys.amount: 0.25, Recipe.IngredientKeys.description: "cup orange juice"],
            [Recipe.IngredientKeys.amount: 0.5, Recipe.IngredientKeys.description: "cup vanilla yogurt"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "fresh strawberries (for garnishing)"]
        ] as [[String : Any]] as NSObject
        
        recipe.instructions = [
            "Gather the ingredients.",
            "Place the strawberries in the bottom of a blender or food processor fitted with a metal blade. Add the cranberry-raspberry juice and orange juice and top with vanilla yogurt.",
            "Cover and immediately puree until smooth, scraping down the sides if needed.",
            "Pour into glasses and garnish each with a strawberry. Serve immediately."
        ] as NSObject
        
        store.add(recipe)
    }
    
    static func smoothie_de() {
        let recipe = smoothie_Recipe()
        recipe.title = "Erdbeer-Smoothie"
        recipe.portions = 4
        recipe.worktime = 5
        recipe.resttime = 0
        recipe.ingredientsData = [
            [Recipe.IngredientKeys.amount: 600, Recipe.IngredientKeys.description: "g Erdbeeren, geputzt"],
            [Recipe.IngredientKeys.amount: 200, Recipe.IngredientKeys.description: "g Joghurt"],
            [Recipe.IngredientKeys.amount: 250, Recipe.IngredientKeys.description: "ml Milch"],
            [Recipe.IngredientKeys.amount: 2, Recipe.IngredientKeys.description: "Pkt. Vanillezucker"]
        ] as [[String : Any]] as NSObject
        
        recipe.instructions = [
            "Die Erdbeeren waschen, putzen und zusammen mit dem Joghurt, der Milch sowie der in Stücke geschnittenen Banane und dem Vanillezucker fein pürieren.",
            "Sofort in Gläser füllen und mit Trinkhalmen servieren und mit einem Stück Erdbeer am Glasrand garnieren."
        ] as NSObject
        
        store.add(recipe)
    }
}



// MARK: - Burger
extension TestRecipes {
    private static func burger_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Burger")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func burger_en() {
        let recipe = burger_Recipe()
        recipe.title = "Bacon Cheddar Burger"
        recipe.worktime = 45
        recipe.resttime = 0
        
        store.add(recipe)
    }
    
    static func burger_de() {
        let recipe = burger_Recipe()
        recipe.title = "Bacon Cheddar Burger"
        recipe.worktime = 45
        
        store.add(recipe)
    }
}



// MARK: - Lasagne
extension TestRecipes {
    private static func lasagne_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Lasagne")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func lasagne_en() {
        let recipe = lasagne_Recipe()
        recipe.title = "Lasagne"
        recipe.worktime = 60
        recipe.resttime = 0
        
        store.add(recipe)
    }
    
    static func lasagne_de() {
        let recipe = lasagne_Recipe()
        recipe.title = "Lasagne"
        recipe.worktime = 60
        
        store.add(recipe)
    }
}



// MARK: - Lemonade
extension TestRecipes {
    private static func lemonade_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Lemonade")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func lemonade_en() {
        let recipe = lemonade_Recipe()
        recipe.title = "Lemonade"
        recipe.worktime = 10
        recipe.resttime = 5
        
        store.add(recipe)
    }
    
    static func lemonade_de() {
        let recipe = lemonade_Recipe()
        recipe.title = "Limonade"
        recipe.worktime = 10
        recipe.resttime = 5
        
        store.add(recipe)
    }
}



// MARK: - Muffins
extension TestRecipes {
    private static func muffins_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Muffins")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func muffins_en() {
        let recipe = muffins_Recipe()
        recipe.title = "Apple Muffins"
        recipe.worktime = 20
        recipe.resttime = 20
        
        store.add(recipe)
    }
    
    static func muffins_de() {
        let recipe = muffins_Recipe()
        recipe.title = "Apfel-Muffins"
        recipe.worktime = 20
        recipe.resttime = 20
        
        store.add(recipe)
    }
}



// MARK: - Sandwich
extension TestRecipes {
    private static func sandwich_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "Sandwich")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func sandwich_en() {
        let recipe = sandwich_Recipe()
        recipe.title = "New York Club Sandwich"
        recipe.worktime = 20
        recipe.resttime = 0
        
        store.add(recipe)
    }
    
    static func sandwich_de() {
        let recipe = sandwich_Recipe()
        recipe.title = "New York Club Sandwich"
        recipe.worktime = 20
        recipe.resttime = 0
        
        store.add(recipe)
    }
}



// MARK: - Chili Con Carne
extension TestRecipes {
    private static func chiliConCarne_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "ChiliConCarne")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func chiliConCarne_en() {
        let recipe = chiliConCarne_Recipe()
        recipe.title = "Chili Con Carne"
        recipe.worktime = 30
        recipe.resttime = 5
        
        store.add(recipe)
    }
    
    static func chiliConCarne_de() {
        let recipe = chiliConCarne_Recipe()
        recipe.title = "Chili Con Carne"
        recipe.worktime = 30
        recipe.resttime = 5
        
        store.add(recipe)
    }
}



// MARK: - Bowl
extension TestRecipes {
    private static func bowl_Recipe() -> Recipe {
        let recipe = standardRecipe()
        recipe.image = UIImage(named: "FruitBowl")?.jpegData(compressionQuality: 1) ?? Data()
        return recipe
    }
    
    static func bowl_en() {
        let recipe = bowl_Recipe()
        recipe.title = "Breakfast Fruit Bowl"
        recipe.worktime = 10
        recipe.resttime = 0
        
        store.add(recipe)
    }
    
    static func bowl_de() {
        let recipe = bowl_Recipe()
        recipe.title = "Frühstücks-Bowl"
        recipe.worktime = 10
        recipe.resttime = 0
        
        store.add(recipe)
    }
}
