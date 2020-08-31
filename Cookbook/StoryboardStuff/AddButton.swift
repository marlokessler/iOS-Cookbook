//
//  AddButton.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class AddButton: CircularButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    
    
    private func setUp() {
        setBackground(color: .backgroundAccent)
        setForeground()
    }
    
    private func setForeground() {
        let foregroundImageView       = UIImageView(image: UIImage(systemName: "plus"))
        foregroundImageView.tintColor = .white
        
        setForeground(view: foregroundImageView)
    }
}
