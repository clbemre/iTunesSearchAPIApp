//
//  SearchItemCell.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

class SearchItemCell: BaseCollectionViewCell {

    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.layer.cornerRadius = 5
        mContentView.layer.masksToBounds = true
    }

}
