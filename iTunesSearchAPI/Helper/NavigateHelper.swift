//
//  NavigateHelper.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 13.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

class NavigateHelper {

    private init() { }
    
    static func getRootViewController() -> UIViewController {
        return UINavigationController(
            rootViewController: HomePageViewController(viewModel: HomeViewModelFactory().makeViewModel())
        )
    }
}
