//
//  UICollectionView+Extensions.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerCell<T: BaseCollectionViewCell>(_ instance: T.Type) {
        self.register(instance.nibInstance, forCellWithReuseIdentifier: instance.reuseIdentifier)
    }

    func generateReusableCell<T: BaseCollectionViewCell>(_ instance: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: instance.reuseIdentifier, for: indexPath) as! T
    }
}
