//
//  CircularButton.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class CircularButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    
    
    private func setUp() {
        layer.cornerRadius             = circularCornerRadius
        titleLabel?.layer.cornerRadius = circularCornerRadius
    }
    
    private var circularCornerRadius: CGFloat {
        (frame.width < frame.height ? frame.width : frame.height) / 2
    }
}



// MARK: - APIs
extension CircularButton {
    func setForeground(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(view)
    }
    
    func setBackground(color: UIColor) {
        let backgroundImageView       = UIImageView(image: UIImage(systemName: "circle.fill"))
        backgroundImageView.tintColor = .white
        backgroundImageView.frame     = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        addSubview(backgroundImageView)
    }
    
    func setBackground(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(view)
    }
}
