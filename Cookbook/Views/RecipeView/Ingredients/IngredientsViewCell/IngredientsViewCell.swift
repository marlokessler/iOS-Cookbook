//
//  IngredientsViewCell.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class IngredientsViewCell: UITableViewCell {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    var delegate: IngredientsViewCellDelegate?
    var indexPath: IndexPath!
    
    var isInEditMode = false {
        didSet {
            configureAppearance()
        }
    }
    
    var ingredient = [String: Any]() {
        didSet {
            setData()
        }
    }
    
    private var amount: Double { return ingredient[Recipe.IngredientKeys.amount] as? Double ?? 0}
    private var ingredientDescription: String { return ingredient[Recipe.IngredientKeys.description] as? String ?? ""}
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        amountField.delegate      = self
        descriptionField.delegate = self
    }
    
    
    
    private func configureAppearance() {
        amountField.isHidden      = !isInEditMode
        descriptionField.isHidden = !isInEditMode
        ingredientLabel.isHidden  = isInEditMode
    }
    
    
    
    private func setData() {
        setAmountData()
        setDescriptionData()
        setLabelData()
    }
    
    private func setAmountData() {
        amountField.text = format(amount)
    }
    
    private func setDescriptionData() {
        descriptionField.text = "\(ingredientDescription)"
    }
    
    private func setLabelData() {
        let amount = ingredient[Recipe.IngredientKeys.amount] as? Double ?? 0
        let description = ingredient[Recipe.IngredientKeys.description] as? String ?? ""
        
        ingredientLabel.text = "- \(format(amount)) \(description)"
    }
}



extension IngredientsViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text! as NSString
        let newString = nsString.replacingCharacters(in: range, with: string)
        
        switch textField.tag {
        case amountField.tag:
            if newString == "" { return true }
            guard let newAmount = deformat(newString) else { return false }
            delegate?.ingredientDidChange(amount: newAmount, at: indexPath)
            
        case descriptionField.tag:
            delegate?.ingredientDidChange(description: newString, at: indexPath)
            
        default: break
        }
        
        return true
    }
    
    private func checkAmountField() -> Bool {
        let isDouble = Double(amountField.text!) != nil
        return isDouble
    }
    
    private func format(_ double: Double) -> String {
        return NumberFormatter.localizedString(from: NSNumber(value: double), number: .decimal)
    }
    
    private func deformat(_ string: String) -> Double? {
        let formatter = NumberFormatter()
        let double = formatter.number(from: string)?.doubleValue
        return double
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case amountField.tag: focusDescriptionField()
        case descriptionField.tag: unfocusDescriptionField()
        default: break
        }
        
        return true
    }

    private func focusDescriptionField() {
        descriptionField.becomeFirstResponder()
    }
    
    private func unfocusDescriptionField() {
        descriptionField.resignFirstResponder()
    }
}
