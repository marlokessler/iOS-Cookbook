//
//  MainCoordinator.swift
//  Cookbook
//
//  Created by Marlo Kessler on 19.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    var childCoordinators = [Coordinator]()
    var rootViewController: UINavigationController
    
    func start() {
        let vc = RecipesOverviewController.instantiate()
        vc.coordinator = self
        rootViewController.pushViewController(vc, animated: false)
    }
}



// MARK: - RecipesCoordinator
extension MainCoordinator: RecipesCoordinatorProtocol {
    func createRecipe() {
        let newRecipeVC = NewRecipeViewController.instantiate()
        newRecipeVC.coordinator = self

        let navigationController = UINavigationController(rootViewController: newRecipeVC)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle   = .crossDissolve

        rootViewController.present(navigationController, animated: true, completion: nil)
    }
    
    func show(_ recipe: Recipe, inEditMode: Bool, animated: Bool) {
        let vc = RecipeViewController.instantiate()
        vc.recipe = recipe
        vc.shouldAppearInEditMode = inEditMode
        rootViewController.pushViewController(vc, animated: animated)
    }
}



// MARK: - RecipesCoordinator
extension MainCoordinator: IntroCoordinatorProtocol {
    func checkForIntroScreen() {
        let introScreenWasPresentedBefore = UserDefaults().bool(forKey: "IntroScreenShown")
        
        if !introScreenWasPresentedBefore {
            let vc = Introscreen.instantiate()
            rootViewController.present(vc, animated: true, completion: nil)
                        
            // Set marker that intro screen has been shown
            UserDefaults().set(true, forKey: "IntroScreenShown")
        }
    }
}
