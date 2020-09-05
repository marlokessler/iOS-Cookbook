//
//  InstructionsViewCell.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class InstructionsViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var instructionView: UITextView!
            
    var delegate: InstructionsViewCellDelegate?
    
    var indexPath = IndexPath(row: 0, section: 0) {
        didSet {
            setNumberLabel()
        }
    }
    
    var instruction = "" {
        didSet {
            setInstructionView()
        }
    }
    
    var isInEditMode = false {
        didSet {
            setInstructionView()
            updateAppearance()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    
    
    private func setUp() {
        instructionView.delegate          = self
        instructionView.layer.borderColor = UIColor.lightGray.cgColor
        instructionView.clipsToBounds     = true
    }
    
    private func updateAppearance() {
        instructionView.isEditable         = isInEditMode
        instructionView.layer.cornerRadius = isInEditMode ? 10 : 0
        instructionView.layer.borderWidth  = isInEditMode ? 1 : 0
        
        // Prevents a fading transition when changing background color.
        UIView.setAnimationsEnabled(false)
        instructionView.backgroundColor    = isInEditMode ? .background2 : .background
        UIView.setAnimationsEnabled(true)
    }
    
    private func setNumberLabel() {
        numberLabel.text = "\(indexPath.row + 1)"
    }
    
    private func setInstructionView() {
        instructionView.text = instruction
    }
}



// MARK: - UITextViewDelegate
extension InstructionsViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        #if DEBUG
        print("InstructionTextView changed")
        #endif
        delegate?.instructionDidChange(to: textView.text, at: indexPath)
        checkTableViewSize()
    }
    
    func checkTableViewSize() {
        let size = instructionView.bounds.size
        let newSize = instructionView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            delegate?.cellHeightDidChange(at: indexPath)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        #if DEBUG
        print("InstructionTextView should end editing")
        #endif
        delegate?.instructionCellDidEndEditing(with: instructionView.text, at: indexPath)
    }
}
