//
//  TitleViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class TitleViewController: RecipeViewContainerController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    var recipe: Recipe! {
        didSet {
            setTitle()
        }
    }
    
    var isInEditMode = false {
        didSet {
            setTitle()
            updateAppearance()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    private func updateAppearance() {
        label.isHidden     = isInEditMode
        textField.isHidden = !isInEditMode
        textField.resignFirstResponder()
    }
    
    private func setTitle() {
        let title = recipe.title
        
        label.text     = title
        textField.text = title
    }
}


extension TitleViewController: RecipeViewContainerProtocol {
    var hasUnsavedChanges: Bool { return recipe.title != textField.text }
    
    func commitChanges() {
        recipe.title = textField.text
        setTitle()
    }
}
