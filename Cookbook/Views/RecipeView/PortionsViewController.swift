//
//  PortionsViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 31.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class PortionsViewController: RecipeViewContainerController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var amountField: UITextField!
    
    
    var recipe: Recipe! {
        didSet {
            setData()
        }
    }
    
    var isInEditMode = false {
        didSet {
            updateAppearance()
            setData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountField.delegate = self
    }
    
    
    
    private func updateAppearance() {
        amountField.isHidden = !isInEditMode
    }
    
    private func setData() {
        let portions = recipe.portions
        
        amountField.text = "\(portions)"
        label.text       = isInEditMode ? "Portions:".localized() : String(format: "For %d Portions".localized(), portions)
    }
}



// MARK: - RecipeViewContainerProtocol
extension PortionsViewController: RecipeViewContainerProtocol {
    var hasUnsavedChanges: Bool {
        return Int(amountField.text!) ?? 0 != recipe.portions
    }
    
    func commitChanges() {
        guard let newNumberOfPortions = Int(amountField.text!) else { return }
        recipe.portions = Int16(newNumberOfPortions)
    }
}



// MARK: - RecipeViewContainerProtocol
extension PortionsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isInteger = Int(string) != nil
        let isEmptyString = string == ""
        
        return isInteger || isEmptyString
    }
}
