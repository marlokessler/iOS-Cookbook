//
//  DurationViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class DurationViewController: RecipeViewContainerController {
    
    @IBOutlet weak var worktimeField: UITextField!
    @IBOutlet var worktimeEditLabels: [UILabel]!
    @IBOutlet weak var worktimeLabel: UILabel!
    
    @IBOutlet weak var resttimeField: UITextField!
    @IBOutlet var resttimeEditLabels: [UILabel]!
    @IBOutlet weak var resttimeLabel: UILabel!
    
    
    
    var recipe: Recipe! {
        didSet {
            setDurationData()
        }
    }
    
    var isInEditMode = false {
        didSet {
            updateAppearance()
            setDurationData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worktimeField.delegate = self
        resttimeField.delegate = self
    }
    
    
    
    private func updateAppearance() {
        worktimeEditLabels.forEach { $0.isHidden = !isInEditMode }
        worktimeField.isHidden = !isInEditMode
        worktimeLabel.isHidden = isInEditMode
        
        resttimeEditLabels.forEach { $0.isHidden = !isInEditMode }
        resttimeField.isHidden = !isInEditMode
        resttimeLabel.isHidden = isInEditMode
    }
    
    private func setDurationData() {
        let worktimeString = formattedString(for: recipe.worktime)
        worktimeField.text = worktimeString
        worktimeLabel.text = String(format: "Work time: %@ min".localized(), worktimeString)
        
        let resttimeString = formattedString(for: recipe.resttime)
        resttimeField.text = resttimeString
        resttimeLabel.text = String(format: "Rest time: %@ min".localized(), resttimeString)
    }
    
    private func formattedString(for number: Double) -> String {
        let convertedNumber = NSNumber(value: number)

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 // maximum digits in Double after dot (maximum precision)

        return String(formatter.string(from: convertedNumber) ?? "")
    }
}



// MARK: - RecipeViewContainerProtocol
extension DurationViewController: RecipeViewContainerProtocol {
    var hasUnsavedChanges: Bool {
        
        let worktimeChanged = recipe.worktime != Double(worktimeField.text!)
        let resttimeChanged = recipe.resttime != Double(resttimeField.text!)
        
        return worktimeChanged || resttimeChanged
    }
    
    func commitChanges() {
        if let worktime = Double(worktimeField.text!) {
            recipe.worktime = worktime
        }
        if let resttime = Double(resttimeField.text!) {
            recipe.resttime = resttime
        }
    }
}



// MARK: - RecipeViewContainerProtocol
extension DurationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isInteger = Int(string) != nil
        let isEmptyString = string == ""
        
        return isInteger || isEmptyString
    }
}

