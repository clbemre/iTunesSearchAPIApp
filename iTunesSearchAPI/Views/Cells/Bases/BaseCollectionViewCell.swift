//
//  BaseCollectionViewCell.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//


import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    class var reuseIdentifier: String {
        return "\(self)"
    }

    class var nibInstance: UINib {
        return .init(nibName: "\(self)", bundle: nil)
    }

}

protocol ConfigurableCell where Self: BaseCollectionViewCell {
    associatedtype DataType
    func configure(data: DataType)
}
