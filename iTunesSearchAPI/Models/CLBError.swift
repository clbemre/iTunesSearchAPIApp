//
//  CLBError.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 10.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

public struct CLBError: Error {
    let errorMessage: String
    let statusCode: Int
}

extension CLBError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(errorMessage, comment: "")
    }
}
