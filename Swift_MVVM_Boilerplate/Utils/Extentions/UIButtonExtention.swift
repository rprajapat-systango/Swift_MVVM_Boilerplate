//
//  UIButtonExtention.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

extension UIView{
    func configure(_ cornerRadius: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = borderColor.cgColor;
        self.layer.cornerRadius = cornerRadius;
    }
}
