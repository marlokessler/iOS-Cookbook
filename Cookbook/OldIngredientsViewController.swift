//
//  IngredientsViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit


// TODOs:
// - Update when ingredient in Store changes
// - Update, when Ingredient added
// - Update, when last ingredient is not used
// - Update, when press return from last cellField

//class OldIngredientsViewController: UIViewController {
    
//    init(for tableView: UITableView, tableViewHeightContraint: NSLayoutConstraint, addButton: AddButton, addButtonViewHeightConstraint: NSLayoutConstraint) {
//        self.tableView = tableView
//        self.tableViewHeightContraint = tableViewHeightContraint
//        self.addButton = addButton
//        self.addButtonViewHeightConstraint = addButtonViewHeightConstraint
//
//        super.init()
//
//        setUpIngredientsView()
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpIngredientsView()
//    }
//
//
//
//    let tableView: UITableView
//    let tableViewHeightContraint: NSLayoutConstraint
//
//    let addButton: UIButton
//    let addButtonViewHeightConstraint: NSLayoutConstraint
//
//
//
//    var ingredients = [Ingredient]() {
//        didSet {
//            tableView.reloadData()
//            updateTableViewHeight()
//        }
//    }
//
//    private var  numberOfIngredients: Int {
//        return ingredients.count
//    }
//
//
//
//    private let ingredientsViewCellID = "IngredientsViewCell"
//
//    private var isInEditMode = false {
//        didSet {
//            tableView.setEditing(self.isInEditMode, animated: true)
//            updateCellsAppearance()
//            updateAddButtonAppearance()
//        }
//    }
//
//    var didChangeWhileEditing: Bool {
//        return false
//    }
//
//
//
//    private func setUpIngredientsView() {
//        tableView.register(UINib(nibName: ingredientsViewCellID, bundle: nil), forCellReuseIdentifier: ingredientsViewCellID)
//        tableView.dataSource = self
//    }
//
//
//
//    private func updateTableViewHeight() {
//        tableViewHeightContraint.constant = tableView.contentSize.height
//    }
//
//    private func updateCellsAppearance() {
//        for cell in tableView.visibleCells {
//            guard let ingredientsCell = cell as? IngredientsViewCell else { return }
//            ingredientsCell.isInEditMode = isInEditMode
//        }
//    }
//
//    private func updateAddButtonAppearance() {
//        addButtonViewHeightConstraint.constant = isInEditMode ? 50 : 0
//        addButton.isHidden = isInEditMode
//    }
//
//
////    private func ingredientsView(cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
////        guard let ingredientsViewCell = cell as? IngredientsViewCell else { return cell }
////        let configuredCell = configure(ingredientsViewCell, at: indexPath)
////
////        return configuredCell
////    }
//
//
//
////    @objc func addIngredientButtonPressed(_ sender: AddButton) {
////        let newIngredient = Ingredient(context: IngredientsStore.shared.objectContext)
////        ingredients.append(newIngredient)
////
////        let nextIndexPath = IndexPath(row: ingredients.count, section: 0)
////        ingredientsTableView.insertRows(at: [nextIndexPath], with: .top)
////        updateIngredientsTableViewHeight()
////
////    }
//
//    private func updateIngreditents() {
//        for ingredient in ingredients {
//            IngredientsStore.shared.update(ingredient)
//        }
//    }
//}
//
//
//
//// MARK: - APIs
//extension IngredientsViewController {
//    func switchToEditMode() {
//        isInEditMode = true
//    }
//
//    func finishEditing() {
//        updateIngreditents()
//        isInEditMode = false
//    }
//
//    func cancelEditing() {
//        isInEditMode = false
//    }
//}
//
//
//
//// MARK: - UITableViewDataSource
//extension IngredientsViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return numberOfIngredients
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
//        let ingredientForThisCell = ingredients[indexPath.row]
//
//        let formattedNumberString = formattedString(for: ingredientForThisCell.amount)
//        cell.amountField.text = formattedNumberString
//
//        let ingredientDescription = ingredientForThisCell.ingredientDescription ?? ""
//        cell.ingredientDescriptionField.text = ingredientDescription
//
//        cell.ingredientLabel.text = "- \(formattedNumberString) \(ingredientDescription)"
//
//        cell.isInEditMode = self.isInEditMode
//
//        return cell
//    }
//
//
//
//    private func formattedString(for number: Double) -> String {
//        let convertedNumber = NSNumber(value: number)
//
//        let formatter = NumberFormatter()
//        formatter.minimumFractionDigits = 0
//        formatter.maximumFractionDigits = 16 // maximum digits in Double after dot (maximum precision)
//
//        return String(formatter.string(from: convertedNumber) ?? "")
//    }
//}
