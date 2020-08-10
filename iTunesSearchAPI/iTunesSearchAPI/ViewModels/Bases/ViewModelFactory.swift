//
//  ViewModelFactory.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

protocol ViewModelFactory {

    associatedtype Target: TargetType
    associatedtype B: IBaseManager
    associatedtype V: IBaseViewModel

    func makeProvider() -> MoyaProvider<Target>
    func makeManager() -> B
    func makeViewModel() -> V
}

extension ViewModelFactory {

    func createMoyaProvider<Target: TargetType>(targetType: Target.Type) -> MoyaProvider<Target> {
        let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.manager.session.configuration.timeoutIntervalForRequest = 120
        return provider
    }

}
