//
//  BaseManager.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 10.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

protocol IBaseManager { }

class BaseManager<Target: TargetType>: IBaseManager {

    private var provider: MoyaProvider<Target>

    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }

    func mRequest<T: Codable>(_ target: Target, callback: @escaping (T?, CLBError?) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(T.self, from: response.data)
                    callback(response, nil)
                } catch {
                    callback(nil, self.createCLBError(error: "Unidentified error!", statusCode: -98))
                }
            case .failure(let error):
                callback(nil, self.createCLBError(error: error.localizedDescription, statusCode: -99))
            }
        }
    }

    
    /// For TargetType to use this method DownloadableTargetType must be implemented.
    /// - Parameters:
    ///   - target: TargetType implemented DownloadableTargetType
    ///   - callback: generic response completion
    func downloadFileRequest<T: Codable>(_ target: Target, callback: @escaping (T?, CLBError?) -> Void) {
        if target is DownloadableTargetType {
            provider.request(target) { (result) in
                switch result {
                case .success(_):
                    do {
                        let jsonData = try Data(contentsOf: (target as! DownloadableTargetType).localLocation, options: .alwaysMapped)
                        let response = try JSONDecoder().decode(T.self, from: jsonData)
                        callback(response, nil)
                    } catch {
                        callback(nil, self.createCLBError(error: "Unidentified error!", statusCode: -98))
                    }
                case .failure(let error):
                    callback(nil, self.createCLBError(error: error.localizedDescription, statusCode: -99))
                }
            }
        } else {
            fatalError("for TargetType: must be implemented DownloadableTargetType")
        }
    }

    private func createCLBError(error: String, statusCode: Int) -> CLBError {
        return CLBError(errorMessage: error, statusCode: statusCode)
    }
}
