//
//  IngredientsViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 31.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class IngredientsViewController: RecipeViewContainerController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var footerContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButton: AddButton!
    @IBOutlet weak var noIngredientsLabel: UILabel!
    
    
    
    private var ingredientsBuffer = [[String : Any]]()
    private let cellID = "IngredientsViewCell"
    
    
    
    var recipe: Recipe! {
        didSet {
            setData()
            updateAppearance()
        }
    }
    
    var isInEditMode = false {
        didSet {
            setData()
            updateAppearance()
        }
    }
    
    private var numberOfIngredients: Int { return ingredientsBuffer.count }
    
    private var recipeIngredients: [[String : Any]] { return recipe.ingredients }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    
    private func setUpViews() {
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        addButton.addTarget(self, action: #selector(self.addButtonPressed), for: .touchUpInside)
    }
    
    private func setData() {
        ingredientsBuffer = recipeIngredients
        tableView.reloadData()
        resizeTableView()
    }
    
    private func updateAppearance() {
        tableView.setEditing(self.isInEditMode, animated: true)
        resizeTableView()
        
        for cell in tableView.visibleCells {
            guard let ingredientCell    = cell as? IngredientsViewCell else { continue }
            ingredientCell.isInEditMode = isInEditMode
        }
        
        addButton.isHidden = !isInEditMode
        
        let noIngredients = ingredientsBuffer.isEmpty
        
        let footerHeight: CGFloat = isInEditMode
                                    ? 50
                                    : noIngredients
                                        ? 20
                                        : 0
        footerContainerHeightConstraint.constant = footerHeight
        noIngredientsLabel.isHidden              = isInEditMode || !noIngredients
    }
    
    private func resizeTableView(additionalSpaceFor additionalRows: Int = 0) {
        var additionalHeight: CGFloat = 8
        
        if additionalRows != 0 {
            let rowHeight = numberOfIngredients == 0
                            ? 44
                            : tableView.contentSize.height / CGFloat(numberOfIngredients)
            additionalHeight += CGFloat(additionalRows) * rowHeight
        }
        
        let height = tableView.contentSize.height + additionalHeight
        
        UIView.animate(withDuration: 0.25) {
            self.tableViewHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
}



// MARK: - IngredientsManagement
extension IngredientsViewController {
    @objc private func addButtonPressed() {
        #if DEBUG
        print("Add button pressed")
        #endif
        addNewIngredient()
    }
    
    private func addNewIngredient() {
        resizeTableView(additionalSpaceFor: 1)
        
        tableView.performBatchUpdates({
            let newIngredient: [String : Any] = [Recipe.IngredientKeys.amount: 0,
                                                 Recipe.IngredientKeys.description: ""]
            ingredientsBuffer.append(newIngredient)
            let newIndexPath = IndexPath(row: numberOfIngredients - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .top)
        }, completion: nil)
    }
    
    private func removeLastIngredient() {
        let removingRow       = numberOfIngredients - 1
        let removingIndexPath = IndexPath(row: removingRow, section: 0)
        removeIngredient(at: removingIndexPath)
    }
    
    private func removeIngredient(at indexPath: IndexPath) {
        resizeTableView(additionalSpaceFor: -1)
        
        tableView.performBatchUpdates({
            let removingRow = indexPath.row
            ingredientsBuffer.remove(at: removingRow)
            
            let removingIndexPath = IndexPath(row: removingRow, section: 0)
            tableView.deleteRows(at: [removingIndexPath], with: .top)
        }, completion: { _ in
            self.tableView.reloadData()
        })
    }
}



// MARK: - RecipeViewContainerProtocol
extension IngredientsViewController: RecipeViewContainerProtocol {
    var hasUnsavedChanges: Bool {
        if recipeIngredients.count != ingredientsBuffer.count { return true }
        
        var index = 0
        while index < numberOfIngredients {
            let recipeIngredient   = recipeIngredients[index]
            let bufferedIngredient = ingredientsBuffer[index]
            
            guard let recipeAmount   = recipeIngredient[Recipe.IngredientKeys.amount] as? Double,
                  let bufferedAmount = bufferedIngredient[Recipe.IngredientKeys.amount] as? Double,
                  recipeAmount == bufferedAmount else { return true }
            
            guard let recipeDescription   = recipeIngredient[Recipe.IngredientKeys.description] as? String,
                  let bufferedDescription = bufferedIngredient[Recipe.IngredientKeys.description] as? String,
                  recipeDescription == bufferedDescription else { return true }
            
            index += 1
        }
        
        return false
    }
    
    func commitChanges() {
        recipe.ingredientsData = ingredientsBuffer as NSObject
    }
}



// MARK: - UITableViewDelegate
extension IngredientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: removeIngredient(at: indexPath)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isInEditMode
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}



// MARK: - UITableViewDataSource
extension IngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfIngredients
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let instructionCell = dequeuedCell as? IngredientsViewCell else { return dequeuedCell }
        let configuredCell = configure(instructionCell, at: indexPath)
        return configuredCell
    }
    
    private func configure(_ cell: IngredientsViewCell, at indexPath: IndexPath) -> IngredientsViewCell {
        cell.delegate     = self
        cell.indexPath    = indexPath
        cell.isInEditMode = self.isInEditMode
        
        let ingredient  = ingredientsBuffer[indexPath.row]
        cell.ingredient = ingredient
        
        return cell
    }
}



// MARK: - InstructionsViewCellDelegate
extension IngredientsViewController: IngredientsViewCellDelegate {
    func ingredientDidChange(amount: Double, at indexPath: IndexPath) {
        #if DEBUG
        print("Ingredent amount did change to \(amount)")
        #endif
        ingredientsBuffer[indexPath.row][Recipe.IngredientKeys.amount] = amount
    }
    
    func ingredientDidChange(description: String, at indexPath: IndexPath) {
        #if DEBUG
        print("Ingredent description did change to \(description)")
        #endif
        ingredientsBuffer[indexPath.row][Recipe.IngredientKeys.description] = description
    }
    
    func ingredientCellDidEndEditing(with amount: Double, and description: String, at indexPath: IndexPath) {
        guard indexPath.row == numberOfIngredients - 1,
              amount == 0,
              description == "" else { return }
        removeLastIngredient()
    }
}
