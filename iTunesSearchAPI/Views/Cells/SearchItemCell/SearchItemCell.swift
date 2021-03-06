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

        self.mContentView.backgroundColor = .white
        self.labelTitle.text = ""
        self.imageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.layer.cornerRadius = 5
        mContentView.layer.masksToBounds = true
        mContentView.setDefaultFlurShadow()

        labelTitle.font = FontBook.Roboto.Medium.of(size: 14)
    }

    func configure(data: SearchItemModel) {
        mContentView.backgroundColor = data.clicked ? .lightGray : .white

        labelTitle.text = "\(data.collectionName) - \(data.trackName)"

        ImageLoader.image(for: URL(string: data.artworkUrl60)!) { [weak self] (image) in
            self?.imageView.image = image
        }

    }

}
