//
//  ImageViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 30.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class ImageViewController: RecipeViewContainerController {
    
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageviewOverlayButton: UIButton!
    @IBOutlet weak var button: RoundedButton!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var buttonContainerHeightConstraint: NSLayoutConstraint!
    
    
    
    private var newImage: UIImage? {
        didSet {
            setImage()
        }
    }
    
    var recipe: Recipe! {
        didSet {
            setImage()
        }
    }
    
    var isInEditMode = false {
        didSet {
            newImage = nil
            setImage()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        imageviewOverlayButton.addTarget(self, action: #selector(self.showImagePicker), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.showImagePicker), for: .touchUpInside)
        
        imageView.layer.cornerRadius       = 20
        buttonContainer.layer.cornerRadius = 20
        buttonContainer.layer.borderColor  = UIColor.backgroundAccent.cgColor
    }
    
    
    
    private func setImage() {
        if let image = newImage {
            imageView.image = image
        } else if let data = recipe.image, let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = nil
        }
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        imageviewOverlayButton.isHidden = !isInEditMode
        button.isHidden                 = !isInEditMode
        
        let noImageAvailable = imageView.image == nil
        
        let buttonTitle = noImageAvailable ? "Add Image".localized() : "Edit Image".localized()
        button.setTitle(buttonTitle, for: .normal)
        
        buttonContainer.layer.borderWidth        = isInEditMode && noImageAvailable ? 2 : 0
        buttonContainerHeightConstraint.constant = !isInEditMode
                                                    ? 0
                                                    : noImageAvailable
                                                        ? view.frame.width * 9/16
                                                        : 50
    }
}



//MARK: - RecipeViewContainerProtocol
extension ImageViewController: RecipeViewContainerProtocol {
    var hasUnsavedChanges: Bool { return newImage != nil }
    
    func commitChanges() {
        if let image = newImage, let data = image.jpegData(compressionQuality: 1) {
            recipe.image = data
        }
        
        setImage()
    }
}



// MARK: - ImagePicker
extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func showImagePicker() {
        #if DEBUG
        print("Should show Image Picker.")
        #endif
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        #if DEBUG
        print("Image picking finished.")
        #endif
        
        if let newImage = info[.editedImage] as? UIImage {
            self.newImage = newImage
        } else if let newImage = info[.originalImage] as? UIImage {
            self.newImage = newImage
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        #if DEBUG
        print("Image picking canceled.")
        #endif
        
        newImage = nil
        picker.dismiss(animated: true)
    }
}
