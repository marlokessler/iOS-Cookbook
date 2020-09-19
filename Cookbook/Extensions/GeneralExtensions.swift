//
//  GeneralExtensions.swift
//  Cookbook
//
//  Created by Marlo Kessler on 18.09.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation

func asynchronously(_ execute: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
        execute()
    }
}
