//
//  InstructionsViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 31.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class InstructionsViewController: RecipeViewContainerController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: AddButton!
    @IBOutlet weak var buttonContainerHeightConstraint: NSLayoutConstraint!
    
    
    
    var recipe: Recipe! {
        didSet {}
    }
    
    var isInEditMode = false {
        didSet {}
    }
    
    let cellID = "InstructionsViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.dataSource = self
    }
    
    
}



// MARK: - RecipeViewContainerProtocol
extension InstructionsViewController: RecipeViewContainerProtocol {
    
    
    var hasUnsavedChanges: Bool {
        return false
    }
    
    func commitChanges() {}
}



// MARK: - UITableViewDataSource
extension InstructionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}

