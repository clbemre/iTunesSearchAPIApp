//
//  HomePageManager.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 10.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

protocol HomePageServiceProtocol {

    func fetchSearchList(term: String, limit: Int, completion: @escaping (SearchResponse?, CLBError?) -> Void)
}

class HomePageManager: BaseManager<HomePageService>, HomePageServiceProtocol {

    override init(provider: MoyaProvider<HomePageService>) {
        super.init(provider: provider)
    }

    func fetchSearchList(term: String, limit: Int, completion: @escaping (SearchResponse?, CLBError?) -> Void) {
        mRequest(.search(term: term, limit: limit), callback: completion)
    }
}
