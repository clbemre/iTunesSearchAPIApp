//
//  HomePageService.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 10.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

enum HomePageService {

    case search(term: String, limit: Int)
}

extension HomePageService: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: NetworkUtil.environmentBaseURL) else { fatalError("Base Url is required") }
        return url
    }

    var path: String {
        switch self {
        case .search(_, _):
            return "/search"
        }
    }

    var method: Method {
        switch self {
        case .search(_, _):
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .search(let term, let limit):
            let params: [String: Any] = [
                "term": term,
                "limit": limit
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)

        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
