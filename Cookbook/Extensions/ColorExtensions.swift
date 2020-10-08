//
//  ColorExtension.swift
//  Cookbook
//
//  Created by Marlo Kessler on 21.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension Color {
    static var primaryAccent: Color { Color("PrimaryAccent") }
    static var background: Color { Color("Background") }
    static var background2: Color { Color("Background 2") }
    static var backgroundAccent: Color { Color("BackgroundAccent") }
    static var introScreenPrimary: Color { Color("IntroScreenPrimary") }
    static var introScreenInverted: Color { Color("IntroScreenInverted") }
}

extension UIColor {
    static var primaryAccent: UIColor { UIColor(named: "PrimaryAccent") ?? .purple }
    static var background: UIColor { UIColor(named: "Background") ?? .systemPurple}
    static var background2: UIColor { UIColor(named: "Background 2") ?? .systemPurple}
    static var backgroundAccent: UIColor { UIColor(named: "BackgroundAccent") ?? .systemPurple}
    static var introScreenPrimary: UIColor { UIColor(named: "IntroScreenPrimary") ?? .white }
    static var introScreenInverted: UIColor { UIColor(named: "IntroScreenInverted") ?? .systemPurple }
}
