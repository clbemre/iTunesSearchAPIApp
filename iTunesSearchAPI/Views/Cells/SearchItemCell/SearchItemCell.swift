//
//  SearchItemCell.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

class SearchItemCell: BaseCollectionViewCell, ConfigurableCell {

    typealias DataType = SearchItemModel

    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.mContentView.backgroundColor = .white
        self.labelTitle.text = ""
        self.imageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.layer.cornerRadius = 5
        mContentView.layer.masksToBounds = true

        mContentView.setDefaultFlurShadow()
    }

    func configure(data: SearchItemModel) {
        labelTitle.text = data.collectionName

        ImageLoader.image(for: URL(string: data.artworkUrl60)!) { [weak self] (image) in
            self?.imageView.image = image
        }

        mContentView.backgroundColor = data.clicked ? .lightGray : .white

    }

}
