//
//  RoundedButton.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override var frame: CGRect {
        didSet {
            self.setCornerRadius()
        }
    }
    
    private func setCornerRadius() {
        let cornerRadius = frame.height / 2
        layer.cornerRadius = cornerRadius
    }
}
