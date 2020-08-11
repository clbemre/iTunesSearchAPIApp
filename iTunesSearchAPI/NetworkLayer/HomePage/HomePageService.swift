//
//  HomePageService.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 10.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

enum HomePageService: DownloadableServiceProtocol {

    case search(term: String, limit: Int)

    var localLocation: URL {
        switch self {
        case .search(_, _):
            return FileSystem.readFileURL(fileKey: "term_searchList", pathExtension: "json")
        }
    }

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
        return "{}".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch self {
        case .search(_, _):
            return .downloadParameters(parameters: self.parameters, encoding: URLEncoding.queryString, destination: downloadDestination)
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .search(let term, let limit):
            return ["term": term, "limit": limit]
        }
    }

    var headers: [String: String]? {
        return [:]
    }
}
