//
//  HomePageViewController.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit
import SnapKit

class HomePageViewController: BaseViewController {

    let viewModel: HomePageViewModel

    init(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        view.backgroundColor = .white
        addAllViews()
        setupCollectionViewConstraints()
    }

    override func initialComponents() {
        self.title = "Search List"

        collectionView.registerCell(SearchItemCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func registerEvents() {

    }

    // MARK: UI Elements
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.generateReusableCell(SearchItemCell.self, indexPath: indexPath)

        cell.mContentView.backgroundColor = .green

        cell.labelTitle.text = "Emre Celebi"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let currentDevice = UIDevice.current
        if currentDevice.orientation.isPortrait
            && currentDevice.userInterfaceIdiom == .phone {
            return CGSize(width: collectionView.frame.size.width - 24, height: 161)
        } else {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: 161)
        }

    }

}


// MARK: UI Setup
extension HomePageViewController {

    func addAllViews() {
        view.addSubview(collectionView)
    }

    // Collection View
    func setupCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(-20)
            maker.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        }
    }
}
