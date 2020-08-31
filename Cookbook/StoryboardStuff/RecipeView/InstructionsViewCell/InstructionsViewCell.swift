//
//  InstructionsViewCell.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class InstructionsViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var instructionView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        instructionView.contentInset = UIEdgeInsets(top: -7, left: 0, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension InstructionsViewCell: UITextViewDelegate {
    
}
