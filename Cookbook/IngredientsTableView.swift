//
//  IngredientsTableView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

//import UIKit
//
//class IngredientsTableView: UITableView {
//
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
////        configureSelf()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
////        configureSelf()
//    }
//
//
//
//    private let ingredientsViewCellID = "IngredientsViewCell"
//
//    var recipe: Recipe? {
//        didSet {
//            guard let recipe = recipe else { return }
//            ingredients = recipe.ingredients
//            reloadData()
//        }
//    }
//
//    private var ingredients = [Ingredient]()
//
//    private var numberOfIngredients: Int {
//        return ingredients.count
//    }
//
//    private var isInEditMode = false {
//        didSet {
//            reloadData()
//        }
//    }
//
//
//
//    private func configureSelf() {
//        delegate = self
//        dataSource = self
//        register(UINib(nibName: ingredientsViewCellID, bundle: nil), forCellReuseIdentifier: ingredientsViewCellID)
//    }
    
//    override func reloadData() {
//        super.reloadData()
//
//    }
//}
//
//
//
//// MARK: - APIs for Editing
//extension IngredientsTableView {
//    func switchToEditMode() {
//        isInEditMode = true
//    }
//
//    func saveEditedData() {
//        // Save
//        isInEditMode = false
//    }
//
//    func cancelEditing() {
//        // Cancel
//        isInEditMode = false
//    }
//
//    func addNewIngredient() {
//
//    }
//}
//
//
//
//// MARK: - UITableViewDataSource
//extension IngredientsTableView: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return numberOfIngredients
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: ingredientsViewCellID, for: indexPath)
//        guard let ingredientsViewCell = dequeuedCell as? IngredientsViewCell else { return dequeuedCell }
//        let configuredCell = configure(ingredientsViewCell, at: indexPath)
//
//        return configuredCell
//    }
//
//
//
//    private func configure(_ cell: IngredientsViewCell, at indexPath: IndexPath) -> IngredientsViewCell {
//
//        if indexPath.row < numberOfIngredients {
//            let ingredientForThisCell = ingredients[indexPath.row]
//
//            let formattedNumberString = formattedString(for: ingredientForThisCell.amount)
//            cell.amountField.text = formattedNumberString
//
//            let ingredientDescription = ingredientForThisCell.ingredientDescription ?? ""
//            cell.ingredientDescriptionField.text = ingredientDescription
//
//            cell.ingredientLabel.text = "- \(formattedNumberString) \(ingredientDescription)"
//
//            cell.isInEditMode = self.isInEditMode
//        } else {
//
//        }
//
//
//        return cell
//    }
//
//
//
//    private func formattedString(for number: Double) -> String {
//
//        let convertedNumber = NSNumber(value: number)
//
//        let formatter = NumberFormatter()
//        formatter.minimumFractionDigits = 0
//        formatter.maximumFractionDigits = 16 // maximum digits in Double after dot (maximum precision)
//
//        return String(formatter.string(from: convertedNumber) ?? "")
//    }
//}



//// MARK: - UITableViewDelegate
//extension IngredientsTableView: UITableViewDelegate {
//
//}
