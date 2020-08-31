//
//  Keyboard.swift
//  Cookbook
//
//  Created by Marlo Kessler on 22.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

//import UIKit
//
//class Keyboard: ObservableObject {
//    private init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(change), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(change), name: UIResponder.keyboardDidHideNotification, object: nil)
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    
//    
//    static let shared = Keyboard()
//    
//    @Published private(set) var height: CGFloat = 0
//    
//    
//    
//    @objc func change(notification: Notification) {
//        height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
//    }
//}
