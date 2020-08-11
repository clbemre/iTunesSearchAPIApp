//
//  UIView+Extensions.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

extension UIView {

    func setDefaultFlurShadow(color: UIColor = UIColor.black.withAlphaComponent(5),
                              shadowRadius: CGFloat = 1.0,
                              shadowOpacity: Float = 0.2) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.masksToBounds = false
    }

}
