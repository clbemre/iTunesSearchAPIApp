//
//  IBaseViewModel.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

protocol IBaseViewModel { }

protocol BaseViewModelDelegate: class {
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
}
