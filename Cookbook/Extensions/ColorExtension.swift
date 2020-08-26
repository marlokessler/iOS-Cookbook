//
//  ColorExtension.swift
//  Cookbook
//
//  Created by Marlo Kessler on 21.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

extension Color {
    static var primaryAccent: Color { Color("PrimaryAccent") }
    static var background: Color { Color("Background") }
    static var backgroundAccent: Color { Color("BackgroundAccent") }
    static var introScreenPrimary: Color { Color("IntroScreenPrimary") }
}

extension UIColor {
    static var primaryAccent: UIColor { UIColor(named: "PrimaryAccent") ?? .purple }
    static var background: UIColor { UIColor(named: "Background") ?? .systemPurple}
    static var backgroundAccent: UIColor { UIColor(named: "BackgroundAccent") ?? .systemPurple}
    static var introScreenPrimary: UIColor { UIColor(named: "IntroScreenPrimary") ?? .white }
}
