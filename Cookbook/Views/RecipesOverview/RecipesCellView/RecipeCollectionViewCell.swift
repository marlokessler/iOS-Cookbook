//
//  RecipeCollectionViewCell.swift
//  Cookbook
//
//  Created by Marlo Kessler on 24.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var deletationButton: DeleteButton!
    
    
    
    private let cornerRadius: CGFloat = 20
    
    
    
    var delegate: RecipeCollectionViewCellDelegate?
    
    var recipe: Recipe? {
        didSet {
            
            guard let recipe = recipe else { return }
            
            // Set imageView
            if let data = recipe.image, let image = UIImage(data: data) {
                self.imageView.isHidden = false
                self.imageView.image    = image
            } else {
                self.imageView.isHidden = true
            }
            
            titleLabel.text    = recipe.title ?? ""
            durationLabel.text = String(format: "%d min".localized(), Int(exactly: recipe.duration) ?? 0)
        }
    }
    
    var indexPath: IndexPath?
    
    var isInEditMode = false {
        didSet {
            deletationButton.isHidden = !self.isInEditMode
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.clipsToBounds      = true
        
        setBlur()
        
        containerView.layer.shadowRadius = 5
    }
    
    
    
    private func setBlur() {
        infoView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView   = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        infoView.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: infoView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: infoView.widthAnchor),
        ])
    }
    
    
    
    @IBAction func deleteButtonPressed(_ sender: DeleteButton) {
        #if DEBUG
        print("Deletation button pressed")
        #endif
        guard let recipe = recipe, let indexPath = indexPath else { return }
        delegate?.didPressDeleteButton(for: recipe, at: indexPath)
    }
}
