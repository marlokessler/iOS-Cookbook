//
//  RecipeViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 24.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var recipe: Recipe!
    
    
    
    var imageVC: ImageViewController!
    var titleVC: TitleViewController!
    var portionsVC: PortionsViewController!
    var durationVC: DurationViewController!
    
    private var isInEditMode = false {
        didSet {
            updateNavBarAppearance()
            
            imageVC.isInEditMode    = self.isInEditMode
            titleVC.isInEditMode    = self.isInEditMode
            portionsVC.isInEditMode = self.isInEditMode
            durationVC.isInEditMode = self.isInEditMode
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBarAppearance()
        self.configureForRecipe()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "embedded_imageView":
            guard let imageVC = segue.destination as? ImageViewController else { return }
            self.imageVC = imageVC
            
        case "embedded_titleView":
            guard let titleVC = segue.destination as? TitleViewController else { return }
            self.titleVC = titleVC
        
        case "embedded_portionsView":
            guard let portionsVC = segue.destination as? PortionsViewController else { return }
            self.portionsVC = portionsVC
            
        case "embedded_durationView":
            guard let durationVC = segue.destination as? DurationViewController else { return }
            self.durationVC = durationVC
            
        default: break
        }
    }
    
    
    
    private func configureForRecipe() {
        configureImageVC()
        configureTitleVC()
        configurePortionsVC()
        configureDurationVC()
    }
    
    private func commitChanges() {
        imageVC.commitChanges()
        titleVC.commitChanges()
        portionsVC.commitChanges()
        durationVC.commitChanges()
        
        RecipesStore.shared.update(recipe)
    }
}



// MARK: - NavBar
extension RecipeViewController {
    private func updateNavBarAppearance() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = !isInEditMode
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesBackButton       = isInEditMode
        
        if self.isInEditMode {
            let saveButton   = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveButtonPressed))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonPressed))
            
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem  = cancelButton
            
        } else {
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editRecipe))
            
            navigationItem.rightBarButtonItem = editButton
            navigationItem.leftBarButtonItem  = nil
        }

    }
    
    @objc private func editRecipe() {
        self.isInEditMode = true
    }
    
    @objc private func saveButtonPressed() {
        self.commitChanges()
        self.isInEditMode = false
    }
    
    @objc private func cancelButtonPressed() {
        self.isInEditMode = false
    }
}



// MARK: - Configure VCs
extension RecipeViewController {
    private func configureImageVC() {
        imageVC.recipe = recipe
    }
    
    private func configureTitleVC() {
        titleVC.recipe = recipe
    }
    
    private func configurePortionsVC() {
        portionsVC.recipe = recipe
    }
    
    private func configureDurationVC() {
        durationVC.recipe = recipe
    }
}


    
    
    
    
    
    
    
//extension RecipeViewController {
    
//    private var newImage: UIImage?
    
//    private var isInEditMode = false {
//        didSet {
//
//        }
//    }
    
//    private var madeChangesWhileEditing: Bool {
//        let imageDidChange = newImage != nil
//        let titleDidChange = titleLabel.text != recipe.title
//        let worktimeDidChange = recipe.worktime != Double(worktimeLabel.text!) ?? 0
//        let resttimeDidChange = recipe.resttime != Double(resttimeLabel.text!) ?? 0
//        let ingredientsDidChange = ingredientsViewController.didChangeWhileEditing
        
//        let didChange = imageDidChange && titleDidChange && worktimeDidChange && resttimeDidChange && ingredientsDidChange
//        return didChange
//    }
    
//    var recipe: Recipe! {
//        didSet {
//            self.configureForRecipe()
//            NotificationCenter.default.addObserver(self, selector: #selector(recipeChanges(notification:)), name: RecipesStore.Update.notificationName, object: nil)
//        }
//    }
    
    
    
    // MARK: - Ingredients
//    @IBOutlet weak var ingredientsTableView:                    UITableView!
//    @IBOutlet weak var ingredientsTableViewHeightContraint:     NSLayoutConstraint!
//    @IBOutlet weak var ingredientsAddButton:                    AddButton!
//    @IBOutlet weak var ingredientsAddButtonViewHeightContraint: NSLayoutConstraint!
//
//    private var ingredientsViewController: IngredientsViewController!
    
//    private func setUpIngredientsViewController() {
//        ingredientsViewController = IngredientsViewController(for: ingredientsTableView,
//                                                              tableViewHeightContraint: ingredientsTableViewHeightContraint,
//                                                              addButton: ingredientsAddButton,
//                                                              addButtonViewHeightConstraint: ingredientsAddButtonViewHeightContraint)
//    }
//
//    private func configureIngredientsViewController() {
//        ingredientsViewController.ingredients = recipe.ingredients
//    }
    
    
    
    // MARK: - Instructions
//    private var instructions = [String]()
//    private let instructionsViewCellID = "InstructionsViewCell"
    
//    @IBOutlet weak var instructionsTableView:                    UITableView!
//    @IBOutlet weak var instructionsTableViewHeightContraint:     NSLayoutConstraint!
//    @IBOutlet weak var instructionsAddButton:                    AddButton!
//    @IBOutlet weak var instructionsAddButtonViewHeightContraint: NSLayoutConstraint!
//}



// MARK: - RecipeViewController
//extension RecipeViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        setUpIngredientsViewController()
//    }
    
//    private func configureForRecipe() {
//        if let image = newImage {
//            imageView.image = image
//        } else if let data = recipe.image, let image = UIImage(data: data) {
//            imageView.image = image
//        }
//
//        titleLabel.text = recipe.title
//
//        worktimeLabel.text = "Work time: \(Int(exactly: recipe.worktime) ?? 0) min"
//        resttimeLabel.text = "Rest time: \(Int(exactly: recipe.resttime) ?? 0) min"
//
////        configureIngredientsViewController()
//    }
//
//    private func confirgureNavigationItem() {
//        if self.isInEditMode {
//            navigationItem.hidesBackButton
//        } else {
//            navigationController.
//        }
//
//    }
//}



// MARK: - RecipesStore Updates
//extension RecipeViewController {
//    @objc func recipeChanges(notification: Notification) {
//        #if DEBUG
//        print("Received a \"recipes changed\" notification.")
//        #endif
//
//        guard let change = notification.object as? RecipesStore.Update else { return }
//
//        switch change {
//
//        case .added(_): break
//
//        case .changed(let changedRecipe):
//            if self.recipe == changedRecipe {
//                self.configureForRecipe()
//            }
//
//        case .deleted(let deletedRecipe):
//            if self.recipe == deletedRecipe {
//                navigationController?.popViewController(animated: true)
//            }
//        }
//    }
//}
