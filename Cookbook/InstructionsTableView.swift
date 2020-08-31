//
//  InstructionsTableView.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

//import UIKit
//
//class InstructionsTableView: UITableView {
//    
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        configure()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        delegate = self
//        configure()
//    }
//    
//    
//    
//    private let instructionsViewCellID = "InstructionsViewCell"
//    
//    
//    
//    private func configure() {
//        register(UINib(nibName: instructionsViewCellID, bundle: nil), forCellReuseIdentifier: instructionsViewCellID)
//    }
//}
//
//
//
//// MARK: - UITableViewDataSource
//extension InstructionsTableView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return tableView.dequeueReusableCell(withIdentifier: instructionsViewCellID, for: indexPath)
//    }
//}
//
//
//
//// MARK: - UITableViewDelegate
//extension InstructionsTableView: UITableViewDelegate {
//    
//}
