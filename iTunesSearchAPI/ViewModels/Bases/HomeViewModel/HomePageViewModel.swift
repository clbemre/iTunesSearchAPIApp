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

    var searchResponse: SearchResponse = SearchResponse(resultCount: 0, results: [])

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
                    self.delegate?.successSearchResponse()
                } else {
                    self.delegate?.showErrorMessage(message: "Unidentified error")
                }
            }
        } else {
            self.delegate?.showErrorMessage(message: "Please check network connection!")
        }
    }

    func numberOfItemsInSection() -> Int {
        return searchResponse.resultCount
    }
    
    func getItem(indexPath: IndexPath) -> SearchItemModel {
        return searchResponse.results[indexPath.row]
    }
}
