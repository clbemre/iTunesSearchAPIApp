//
//  FileSystem.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

class FileSystem {
    static let documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    static let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    static let downloadDirectory: URL = {
        let directory: URL = FileSystem.documentsDirectory.appendingPathComponent("Download/")
        return directory
    }()

    static func readFileURL(fileKey: String, pathExtension: String) -> URL {
        return FileSystem.downloadDirectory.appendingPathComponent(fileKey)
            .appendingPathExtension(pathExtension)
    }

}
