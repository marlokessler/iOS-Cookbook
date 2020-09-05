//
//  DeleteButton.swift
//  Cookbook
//
//  Created by Marlo Kessler on 28.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class DeleteButton: CircularButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    
    
    private func setUp() {
        setBackground(color: .white)
        setForeground()
    }
    
    private func setForeground() {
        let foregroundImageView       = UIImageView(image: UIImage(systemName: "minus.circle.fill"))
        foregroundImageView.tintColor = .systemRed
        
        setForeground(view: foregroundImageView)
    }
}
