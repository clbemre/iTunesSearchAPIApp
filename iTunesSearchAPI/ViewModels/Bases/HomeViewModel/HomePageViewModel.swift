//
//  HomePageViewModel.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

protocol HomePageViewModelProtocol: class {
    init(serviceManager: HomePageManager)
    func search(term: String, limit: Int)
}

protocol HomePageViewModelDelegate: BaseViewModelDelegate {

    func successSearchResponse()
}

class HomePageViewModel: IBaseViewModel, HomePageViewModelProtocol {

    let serviceManager: HomePageManager
    var delegate: HomePageViewModelDelegate? = nil

    var isIphonePortrait: Bool = true

    private var searchResponse: SearchResponse = SearchResponse(resultCount: 0, results: [])

    required init(serviceManager: HomePageManager) {
        self.serviceManager = serviceManager
    }

    func search(term: String, limit: Int) {
        if Utils.isConnectedToNetwork() {
            self.delegate?.showLoading()
            serviceManager.fetchSearchList(term: term, limit: limit) { (response, error) in
                self.delegate?.hideLoading()
                if let error = error {
                    self.delegate?.showErrorMessage(message: error.errorMessage)
                } else if let resp = response {
                    print(resp)
                    self.searchResponse = resp
                    self.syncClickedItems()
                    self.syncDeletedItems()
                    self.delegate?.successSearchResponse()
                } else {
                    self.delegate?.showErrorMessage(message: "Unidentified error")
                }
            }
        } else {
            self.delegate?.showErrorMessage(message: "Please check network connection!")
        }
    }

    // Clicked Items
    private func syncClickedItems() {
        if let clickedItems = LocalDataManager.shared.getClickedItemList(), clickedItems.count > 0 {
            let newList = searchResponse.results.map { (model) -> SearchItemModel in
                var modified = model
                modified.clicked = clickedItems.contains(model.trackID)
                return modified
            }
            self.searchResponse.results = newList
        }
    }

    func syncClickedItem(trackID: UInt64) {
        LocalDataManager.shared.saveClickedItem(id: trackID)
        self.syncClickedItems()
    }

    // Deleted Items
    private func syncDeletedItems() {
        if let deletedItems = LocalDataManager.shared.getDeletedItemList(), deletedItems.count > 0 {
            self.searchResponse.results = searchResponse.results.filter { (model) -> Bool in
                return !deletedItems.contains(model.trackID)
            }
        }
    }

    func syncDeletedItem(trackID: UInt64) {
        LocalDataManager.shared.saveDeletedItem(id: trackID)
        self.syncDeletedItems()
    }

    func numberOfItemsInSection() -> Int {
        return searchResponse.results.count
    }

    func getItem(indexPath: IndexPath) -> SearchItemModel {
        return self.searchResponse.results[indexPath.row]
    }

    func findIndexPath(trackID: UInt64) -> IndexPath? {
        let findIndex = self.searchResponse.results.firstIndex { (item) -> Bool in
            return item.trackID == trackID
        }

        guard let index = findIndex else { return nil }

        return IndexPath(item: index, section: 0)
    }
}
