//
//  NewRecipeViewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 04.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

class NewRecipeViewController: UIViewController {

    @IBOutlet weak var previewNameLabel: UILabel!
    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
    
    var delegate: NewRecipeDelegate?
    var tapOutsideKeyboardRecognizer: UIGestureRecognizer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleField.selectAll(nil)
    }
    
    
    
    private func setUpViews() {
        setNavButtons()
        setBluredBackground()
        
        preView.layer.cornerRadius = 10
        preView.layer.shadowColor  = UIColor.primaryAccent.cgColor
        preView.layer.shadowRadius = 5
        
        previewNameLabel.text = "New Recipe"
        
        titleField.text       = "New Recipe"
        titleField.delegate   = self
        titleField.addTarget(self, action: #selector(self.nameFieldTextChanged(_:)), for: .editingChanged)
        
        self.addKeyboardObserver()
    }
    
    private func setBluredBackground() {
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.effect = UIBlurEffect(style: .light)
        blurredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurredBackgroundView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: blurredBackgroundView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: blurredBackgroundView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: blurredBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: blurredBackgroundView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        ])
        
        view.sendSubviewToBack(blurredBackgroundView)
    }
    
    private func dismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }    
}



// MARK: - NameField
extension NewRecipeViewController: UITextFieldDelegate {
    @objc private func nameFieldTextChanged(_ sender: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = titleIsValid
        previewNameLabel.text = titleField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard titleIsValid else { return true }
        delegate?.createRecipe(with: titleField.text!)
        self.dismiss()
        return true
    }
    
    private var titleIsValid: Bool { titleField.text != "" }
}



// MARK: - Navbar
extension NewRecipeViewController {
    private func setNavButtons() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelNewRecipe(_:)))
        let saveButton   = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.createNewRecipe(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func createNewRecipe(_ sender: UIBarButtonItem) {
        let title = titleField.text!
        self.delegate?.createRecipe(with: title)
        self.dismiss()
    }
    
    @objc private func cancelNewRecipe(_ sender: UIBarButtonItem) {
        self.dismiss()
    }
}



// MARK: - Keyboard
extension NewRecipeViewController {
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(_ notification: Notification) {
        setKeyboardHeight(from: notification)
        addDismissKeyboardTapGesture()
    }
    
    private func setKeyboardHeight(from notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        #if DEBUG
        print("Keyboard will appear, Height changed to: \(keyboardHeight)")
        #endif
        UIView.animate(withDuration: 0.25) {
            self.keyboardHeightConstraint.constant = keyboardHeight
        }
    }
    
    private func addDismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapOutsideKeyboardRecognizer = tapGesture
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardDidHide(_ notification: Notification) {
        if let tapGesture = tapOutsideKeyboardRecognizer {
            self.view.removeGestureRecognizer(tapGesture)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.keyboardHeightConstraint.constant = 0
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.dismiss()
    }
}

protocol NewRecipeDelegate {
    func createRecipe(with title: String)
}
