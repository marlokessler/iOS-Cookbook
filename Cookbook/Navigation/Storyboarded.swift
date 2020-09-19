//
//  Storyboarded.swift
//  Cookbook
//
//  Created by Marlo Kessler on 19.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id             = String(describing: self)
        let storyboard     = UIStoryboard(name: "Main", bundle: Bundle.main)
        let instantiatedVC = storyboard.instantiateViewController(identifier: id) as! Self
        return instantiatedVC
    }
}
