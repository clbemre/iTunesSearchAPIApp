//
//  BaseViewController.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var activityIndicator: CustomProgressView?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityIndicator()
        self.initialComponents()
        self.registerEvents()
    }

    /// This method is used to create UI. (for programmatic)
    func setupView() {
        preconditionFailure("setupView - This method must be overridden")
    }

    /// This method is used for initializations
    func initialComponents() {
        preconditionFailure("initialComponents - This method must be overridden")
    }

    /// This method is used for actions/events.
    func registerEvents() {
        preconditionFailure("registerEvents - This method must be overridden")
    }
}

// MARK: Activity Indicator
extension BaseViewController {

    private func initActivityIndicator() {
        activityIndicator = CustomProgressView(frame: UIScreen.main.bounds)
    }

    func showLoadingIndicator() {
        DispatchQueue.delay(250) { [weak self] in
            guard let window = WindowHelper.getWindow() else { return }
            if let activityIndicator = self?.activityIndicator {
                activityIndicator.showLoadingIndicator(mView: window)
            }
        }
    }

    func hideLoadingIndicator() {
        DispatchQueue.delay(250) { [weak self] in
            if let activityIndicator = self?.activityIndicator {
                activityIndicator.hideLoadingIndicator()
            }
        }
    }
}

// MARK: Alert
extension BaseViewController {

    func showAlertMessage(title: String,
                          message: String,
                          positiveButtonText: String = "OK",
                          positiveHandler: ((UIAlertAction) -> Void)? = nil,
                          negativeButtonText: String? = nil,
                          negativeHandler: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: positiveButtonText, style: .default, handler: positiveHandler))

        if let negativeButtonText = negativeButtonText {
            alert.addAction(UIAlertAction(title: negativeButtonText, style: .cancel, handler: negativeHandler))
        }

        self.present(alert, animated: true, completion: nil)
    }
}
