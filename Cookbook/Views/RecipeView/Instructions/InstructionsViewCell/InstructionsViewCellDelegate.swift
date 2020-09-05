//
//  InstructionsViewCellDelegate.swift
//  Cookbook
//
//  Created by Marlo Kessler on 01.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

protocol InstructionsViewCellDelegate {
    func instructionDidChange(to newInstruction: String, at indexPath: IndexPath)
    func instructionCellDidEndEditing(with finalInstruction: String, at indexPath: IndexPath)
    func cellHeightDidChange(at indexPath: IndexPath)
}
