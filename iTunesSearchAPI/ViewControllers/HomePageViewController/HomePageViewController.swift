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

        viewModel.delegate = self
        viewModel.search(term: "jack+johnson", limit: 100)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        viewModel.isIphonePortrait = DeviceInfo.Orientation.isPortrait && DeviceInfo.UserInterfaceIdiom.isPhone

        self.collectionView.collectionViewLayout.invalidateLayout()
    }


    override func registerEvents() {

    }

}

// MARK: HomePageViewModelDelegate
extension HomePageViewController: HomePageViewModelDelegate {

    func successSearchResponse() {
        self.collectionView.reloadData()
    }

    func showLoading() {
        self.showLoadingIndicator()
    }

    func hideLoading() {
        self.hideLoadingIndicator()
    }

    func showErrorMessage(message: String) {
        showAlertMessage(title: "Error", message: message)
    }

}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.generateReusableCell(SearchItemCell.self, indexPath: indexPath)

        let item = self.viewModel.getItem(indexPath: indexPath)
        cell.labelTitle.text = item.artistName

        ImageLoader.image(for: URL(string: item.artworkUrl100)!) { (image) in
            cell.imageView.image = image
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if viewModel.isIphonePortrait {
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
private extension HomePageViewController {

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
