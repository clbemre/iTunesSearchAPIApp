//
//  DetailViewController.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 12.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit
import AVFoundation
import NVActivityIndicatorView

protocol DetailViewControllerDelegate: class {
    func DetailViewControllerDeleteItem(at deleteItem: SearchItemModel)
}

class DetailViewController: BaseViewController {

    // Banner Image
    let imgBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let titleLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.font = FontBook.Roboto.BoldItalic.of(size: 16)
        label.textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return label
    }()

    // for song
    var songIndicator: NVActivityIndicatorView
        = NVActivityIndicatorView(frame: .zero, type: .lineScalePulseOut, color: UIColor.white, padding: nil)

    var delegate: DetailViewControllerDelegate? = nil

    var player: AVAudioPlayer? = nil

    let viewModel: DetailPageViewModel

    init(viewModel: DetailPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        view.backgroundColor = .white
        songIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        addAllViews()
        setupBannerImageViewConstraints()
        setupTitleLabel()
        setupSongIndicatorConstraints()
    }

    override func initialComponents() {
        self.title = self.viewModel.model.trackName

        self.viewModel.delegate = self

        self.viewModel.downloadSong(serverURL: URL(string: self.viewModel.model.previewURL)!)

        ImageLoader.image(for: URL(string: self.viewModel.model.artworkUrl100)!) { [weak self] (image) in
            self?.imgBanner.image = image
        }

        titleLabel.text = self.viewModel.model.collectionName

    }

    @objc func ActionDeleteButton(_ sender: UIBarButtonItem) {
        self.deleteItem()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.downloadTask?.cancel()
        self.player?.stop()
        self.songIndicator.stopAnimating()
    }
}

// MARK: DetailPageViewModelDelegate
extension DetailViewController: DetailPageViewModelDelegate {
    func showLoading() {
        self.showLoadingIndicator()
    }

    func hideLoading() {
        self.hideLoadingIndicator()
    }

    func showErrorMessage(message: String) {
        showAlertMessage(title: "Error", message: message)
    }

    func downloadedSong(songURL: URL) {
        DispatchQueue.main.async {
            self.playSong(url: songURL)
        }
    }
}

// MARK: Funcs
private extension DetailViewController {

    private func deleteItem() {
        showAlertMessage(title: "Delete", message: "Are you sure you want to delete this song?", positiveButtonText: "Yes", positiveHandler: { _ in
            self.delegate?.DetailViewControllerDeleteItem(at: self.viewModel.model)
            self.navigationController?.popViewController(animated: true)
        }, negativeButtonText: "No", negativeHandler: nil)
    }

    func playSong(url: URL) {

        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.numberOfLoops = -1
            player?.volume = 1.0
            player?.play()
            songIndicator.startAnimating()
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }

    }
}

// MARK: UI Setup
private extension DetailViewController {

    func addAllViews() {
        addDeleteBarButtonItem()
        view.addSubview(imgBanner)
        view.addSubview(titleLabel)
        view.addSubview(songIndicator)
    }

    private func addDeleteBarButtonItem() {
        let barButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(self.ActionDeleteButton(_:)))
        self.navigationItem.rightBarButtonItem = barButton
    }

    func setupBannerImageViewConstraints() {
        imgBanner.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func setupTitleLabel() {
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(imgBanner)
            maker.center.equalToSuperview()
            maker.height.lessThanOrEqualTo(100)
            maker.height.greaterThanOrEqualTo(61)
        }
    }

    func setupSongIndicatorConstraints() {
        songIndicator.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(61)
            maker.top.equalTo(titleLabel.snp.bottom)
            maker.centerX.equalToSuperview()
        }
    }

}
