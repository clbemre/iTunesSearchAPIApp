//
//  DownloadableTargetType.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

protocol DownloadableTargetType: TargetType {
    var localLocation: URL { get }
}

extension DownloadableTargetType {
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, [.removePreviousFile, .createIntermediateDirectories]) }
    }
}
