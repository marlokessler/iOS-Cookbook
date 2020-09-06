//
//  RecipeViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 24.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var keyboardViewHeightConstraint: NSLayoutConstraint!
    
    var recipe: Recipe!
    
    private var imageVC:        ImageViewController!
    private var titleVC:        TitleViewController!
    private var portionsVC:     PortionsViewController!
    private var durationVC:     DurationViewController!
    private var ingredientsVC:  IngredientsViewController!
    private var instructionsVC: InstructionsViewController!
    
    var shouldAppearInEditMode = false
    
    private var isInEditMode = false {
        didSet {
            updateNavBarAppearance()
            
            imageVC.isInEditMode        = self.isInEditMode
            titleVC.isInEditMode        = self.isInEditMode
            portionsVC.isInEditMode     = self.isInEditMode
            durationVC.isInEditMode     = self.isInEditMode
            ingredientsVC.isInEditMode  = self.isInEditMode
            instructionsVC.isInEditMode = self.isInEditMode
        }
    }
    
    private var tapOutsideKeyboardRecognizer: UITapGestureRecognizer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBarAppearance()
        self.configureForRecipe()
        self.addKeyboardObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isInEditMode = shouldAppearInEditMode
    }
    
    
    
    // In the prepare for segue-function the container controllers can be fetched
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
            
        case "embedded_ingredientsView":
            guard let ingredientsVC = segue.destination as? IngredientsViewController else { return }
            self.ingredientsVC = ingredientsVC
            
        case "embedded_instructionsView":
            guard let instructionsVC = segue.destination as? InstructionsViewController else { return }
            self.instructionsVC = instructionsVC
            
        default: break
        }
    }
    
    
    
    private func configureForRecipe() {
        configureImageVC()
        configureTitleVC()
        configurePortionsVC()
        configureDurationVC()
        configureIngredientsVC()
        configureInstructionsVC()
    }
    
    private func commitChanges() {
        imageVC.commitChanges()
        titleVC.commitChanges()
        portionsVC.commitChanges()
        durationVC.commitChanges()
        ingredientsVC.commitChanges()
        instructionsVC.commitChanges()
        
        RecipesStore.shared.update(recipe)
    }
    
    private var hasUnsavedChanges: Bool {
        return imageVC.hasUnsavedChanges       ||
               titleVC.hasUnsavedChanges       ||
               portionsVC.hasUnsavedChanges    ||
               durationVC.hasUnsavedChanges    ||
               ingredientsVC.hasUnsavedChanges ||
               instructionsVC.hasUnsavedChanges
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
        if self.hasUnsavedChanges {
            showCancelAlert()
        } else {
            self.isInEditMode = false
        }
    }
    
    private func showCancelAlert() {
        let style   = UIDevice().userInterfaceIdiom == .phone ? UIAlertController.Style.actionSheet : .alert
        let alert   = UIAlertController(title: "", message: "Are you sure you want to discard your changes?".localized(), preferredStyle: style)
        let discard = UIAlertAction(title: "Discard Changes".localized(), style: .destructive) { _ in self.isInEditMode = false }
        let cancel  = UIAlertAction(title: "Keep Editing".localized(), style: .cancel, handler: nil)
        alert.addAction(discard)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
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
    private func configureIngredientsVC() {
        ingredientsVC.recipe = recipe
    }
    private func configureInstructionsVC() {
        instructionsVC.recipe = recipe
    }
}



// MARK: - Keyboard
extension RecipeViewController {
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(_ notification: Notification) {
        setKeyboardHeight(from: notification)
        addDismissKeyboardTapGesture()
    }
    
    private func setKeyboardHeight(from notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        #if DEBUG
        print("Keyboard will appear, Height changed to: \(keyboardHeight)")
        #endif
        keyboardViewHeightConstraint.constant = keyboardHeight
    }
    
    private func addDismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapOutsideKeyboardRecognizer = tapGesture
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardDidHide(_ notification: Notification) {
        #if DEBUG
        print("Keyboard did hide, Height changed to 0")
        #endif
        keyboardViewHeightConstraint.constant = 0
        if let tapGesture = tapOutsideKeyboardRecognizer {
            self.view.removeGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
