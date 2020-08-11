//
//  NetworkUtil.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 10.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

enum APIEnvironment {
    case dev
    case staging
    case production
}

struct NetworkUtil {
    private static let environment: APIEnvironment = .dev

    static var environmentBaseURL: String {
        switch NetworkUtil.environment {
        case .production: return "https://itunes.apple.com"
        case .staging: return "https://itunes.apple.com"
        case .dev: return "https://itunes.apple.com"
        }
    }
}
