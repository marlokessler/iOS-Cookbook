//
//  InstructionsViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 31.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class InstructionsViewController: RecipeViewContainerController {
    
    @IBOutlet weak var tableView:                 UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var footerContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var button:                          AddButton!
    @IBOutlet weak var noInstructionsLabel:             UILabel!
    
    
    
    private var instructionsBuffer = [String]()
    private let cellID = "InstructionsViewCell"
    
    
    
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
    
    private var numberOfInstructions: Int {
        instructionsBuffer.count
    }
    
    private var recipeInstructions: [String] {
        recipe.instructions as? [String] ?? [String]()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    
    private func setUpViews() {
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.delegate   = self
        tableView.dataSource = self
        
        button.addTarget(self, action: #selector(self.addButtonPressed), for: .touchUpInside)
    }
    
    private func setData() {
        instructionsBuffer = recipeInstructions
        tableView.reloadData()
        resizeTableView()
    }
    
    private func updateAppearance() {
        tableView.setEditing(self.isInEditMode, animated: true)
        resizeTableView()
        
        for cell in tableView.visibleCells {
            guard let instructionCell    = cell as? InstructionsViewCell else { continue }
            instructionCell.isInEditMode = isInEditMode
        }
        
        button.isHidden = !isInEditMode
        
        let noInstructions = instructionsBuffer.isEmpty
        
        let footerHeight: CGFloat = isInEditMode
                                    ? 50
                                    : noInstructions
                                        ? 20
                                        : 0
        footerContainerHeightConstraint.constant = footerHeight
        noInstructionsLabel.isHidden             = isInEditMode || !noInstructions
    }
    
    private func resizeTableView(additionalSpaceFor additionalRows: Int = 0) {
        var additionalHeight: CGFloat = 8
        
        if additionalRows != 0 {
            let rowHeight = 50
            additionalHeight += CGFloat(additionalRows * rowHeight)
        }
        
        let height = tableView.contentSize.height + additionalHeight
        
        UIView.animate(withDuration: 0.25) {
            self.tableViewHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    private func resizeCells() {
        DispatchQueue.main.async {
            UIView.setAnimationsEnabled(false)
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}



// MARK: - InstructionsManagement
extension InstructionsViewController {
    @objc private func addButtonPressed() {
        #if DEBUG
        print("Add button pressed")
        #endif
        addNewInstruction()
    }
    
    private func addNewInstruction() {
        resizeTableView(additionalSpaceFor: 1)
                
        tableView.performBatchUpdates({
            instructionsBuffer.append("")
            let newIndexPath = IndexPath(row: numberOfInstructions - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .top)
        }, completion: nil)
    }
    
    private func removeLastInstruction() {
        let removingRow       = numberOfInstructions - 1
        let removingIndexPath = IndexPath(row: removingRow, section: 0)
        removeInstruction(at: removingIndexPath)
    }
    
    private func removeInstruction(at indexPath: IndexPath) {
        resizeTableView(additionalSpaceFor: -1)
        
        tableView.performBatchUpdates({
            let removingRow = indexPath.row
            instructionsBuffer.remove(at: removingRow)
            let removingIndexPath = IndexPath(row: removingRow, section: 0)
            tableView.deleteRows(at: [removingIndexPath], with: .top)
        }, completion: { _ in
            self.tableView.reloadData()
        })
    }
}



// MARK: - RecipeViewContainerProtocol
extension InstructionsViewController: RecipeViewContainerProtocol {
    var hasUnsavedChanges: Bool {
        if recipeInstructions.count != instructionsBuffer.count { return true }
        
        var index = 0
        while index < numberOfInstructions {
            if recipeInstructions[index] != instructionsBuffer[index] { return true }
            index += 1
        }
        
        return false
    }
    
    func commitChanges() {
        recipe.instructions = instructionsBuffer as NSObject
    }
}



// MARK: - UITableViewDelegate
extension InstructionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: removeInstruction(at: indexPath)
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
extension InstructionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfInstructions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let instructionCell = dequeuedCell as? InstructionsViewCell else { return dequeuedCell }
        let configuredCell = configure(instructionCell, at: indexPath)
        return configuredCell
    }
    
    private func configure(_ cell: InstructionsViewCell, at indexPath: IndexPath) -> InstructionsViewCell {
        cell.delegate     = self
        cell.indexPath    = indexPath
        cell.instruction  = instructionsBuffer[indexPath.row]
        cell.isInEditMode = self.isInEditMode
        return cell
    }
}



// MARK: - InstructionsViewCellDelegate
extension InstructionsViewController: InstructionsViewCellDelegate {
    func cellHeightDidChange(at indexPath: IndexPath) {
        resizeTableView()
    }
    
    func instructionDidChange(to newInstruction: String, at indexPath: IndexPath) {
        #if DEBUG
        print("Instruction did change.")
        #endif
        instructionsBuffer[indexPath.row] = newInstruction
        resizeCells()
    }
    
    func instructionCellDidEndEditing(with finalInstruction: String, at indexPath: IndexPath) {
        guard indexPath.row == numberOfInstructions - 1,
              finalInstruction == "" else { return }
        removeLastInstruction()
    }
}

