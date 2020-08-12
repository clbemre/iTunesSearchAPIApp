//
//  DetailPageViewModel.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 12.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

protocol DetailPageViewModelProtocol: class {
    init(model: SearchItemModel)
    func downloadSong(serverURL: URL)
}

protocol DetailPageViewModelDelegate: BaseViewModelDelegate {

    func downloadedSong(songURL: URL)
}

class DetailPageViewModel: IBaseViewModel, DetailPageViewModelProtocol {

    let model: SearchItemModel
    var downloadTask: URLSessionDownloadTask?
    var delegate: DetailPageViewModelDelegate? = nil

    required init(model: SearchItemModel) {
        self.model = model
    }

    func downloadSong(serverURL: URL) {
        self.delegate?.showLoading()
        downloadTask = URLSession.shared.downloadTask(with: serverURL, completionHandler: { [weak self](songUrl, response, error) -> Void in
            self?.delegate?.hideLoading()
            if let songUrl = songUrl {
                self?.delegate?.downloadedSong(songURL: songUrl)
            } else {
                self?.delegate?.showErrorMessage(message: "The song could not be accessed.")
            }
        })

        downloadTask?.resume()
    }
}
