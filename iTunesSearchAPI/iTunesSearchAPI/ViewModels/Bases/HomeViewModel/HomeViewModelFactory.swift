//
//  HomeViewModelFactory.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Moya

class HomeViewModelFactory: ViewModelFactory {

    typealias Target = HomePageService
    typealias B = HomePageManager
    typealias V = HomePageViewModel

    func makeProvider() -> MoyaProvider<HomePageService> {
        return createMoyaProvider(targetType: HomePageService.self)
    }

    func makeManager() -> HomePageManager {
        return HomePageManager(provider: makeProvider())
    }

    func makeViewModel() -> HomePageViewModel {
        return HomePageViewModel(serviceManager: makeManager())
    }

}
