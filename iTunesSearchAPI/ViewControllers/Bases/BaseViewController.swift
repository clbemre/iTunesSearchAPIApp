//
//  BaseViewController.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit
// MARK: import NVActivityIndicatorView

class BaseViewController: UIViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialComponents()
        self.registerEvents()
    }

    func setupView() {
        preconditionFailure("setupView - This method must be overridden")
    }

    func initialComponents() {
        preconditionFailure("initialComponents - This method must be overridden")
    }

    func registerEvents() {
        preconditionFailure("registerEvents - This method must be overridden")
    }
}
