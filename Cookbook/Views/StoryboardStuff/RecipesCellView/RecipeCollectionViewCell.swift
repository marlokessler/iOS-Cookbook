//
//  RecipeCollectionViewCell.swift
//  Cookbook
//
//  Created by Marlo Kessler on 24.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

//import UIKit
//
//class RecipeCollectionViewCell: UICollectionViewCell {
//        
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var infoView: UIView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var durationLabel: UILabel!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        self.layer.cornerRadius = 20
//        
//        // Set blur effect for infoView
//        setBlur()
//    }
//    
//    private func setBlur() {
//        infoView.backgroundColor = .clear
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        infoView.insertSubview(blurView, at: 0)
//        
//        NSLayoutConstraint.activate([
//            blurView.heightAnchor.constraint(equalTo: infoView.heightAnchor),
//            blurView.widthAnchor.constraint(equalTo: infoView.widthAnchor),
//        ])
//    }
//        
//    func setData(for recipe: Recipe) {
//        print("setData")
//        // Set imageView
//        if let data = recipe.image, let image = UIImage(data: data) {
//            self.imageView.isHidden = false
//            self.imageView.image = image
//        } else {
//            self.imageView.isHidden = true
//        }
//        
//        // Set title
//        titleLabel.text = recipe.title ?? ""
//        durationLabel.text = "\(Int(exactly: recipe.duration) ?? 0) min"
//    }
//}
