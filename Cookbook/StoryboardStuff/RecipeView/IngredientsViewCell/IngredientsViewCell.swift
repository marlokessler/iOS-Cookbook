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
    @IBOutlet weak var ingredientDescriptionField: UITextField!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    var isInEditMode = false {
        didSet {
            configureAppearance()
        }
    }
    
//    var delegate: IngredientsViewCellDelegate?
//    var indexPath: IndexPath?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amountField.delegate = self
        ingredientDescriptionField.delegate = self
    }
    
    private func configureAppearance() {
        amountField.isHidden = !isInEditMode
        ingredientDescriptionField.isHidden = !isInEditMode
        ingredientLabel.isHidden = isInEditMode
    }
}



extension IngredientsViewCell: UITextFieldDelegate {
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        let shouldReturn = chooseNextFocusedTextField(from: textField)
//
//        return shouldReturn
//    }
//
//    private func chooseNextFocusedTextField(from textField: UITextField) -> Bool {
//        switch textField.tag {
//
//        case amountField.tag:
//            ingredientDescriptionField.becomeFirstResponder()
//
//        case ingredientDescriptionField.tag:
//            guard let indexPath = indexPath else { return true }
//            delegate?.cellDidReturn(at: indexPath)
//
//        default: return true
//        }
//
//        return false
//    }
}
