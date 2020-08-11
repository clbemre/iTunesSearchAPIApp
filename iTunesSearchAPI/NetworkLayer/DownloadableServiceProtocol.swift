//
//  DownloadableServiceProtocol.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

protocol DownloadableServiceProtocol {
    var localLocation: URL { get }
}

extension DownloadableServiceProtocol {
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, [.removePreviousFile, .createIntermediateDirectories]) }
    }
}
