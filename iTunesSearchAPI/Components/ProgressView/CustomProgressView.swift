//
//  CustomProgressView.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CustomProgressView: BaseUIView {

    var activityIndicator: NVActivityIndicatorView?

    override func initializeSelf() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator = NVActivityIndicatorView(frame:
            CGRect(x: frame.width / 2 - 30,
                   y: frame.height / 2 - 30,
                   width: 60,
                   height: 60), type: .ballRotateChase, color: UIColor.white, padding: nil)
    }

}

extension CustomProgressView {

    // MARK: Activity Indicator
    func showLoadingIndicator(mView: UIView) {
        if let activityIndicator = activityIndicator {
            addSubview(activityIndicator)
            mView.addSubview(self)
            activityIndicator.startAnimating()
        }
    }

    func hideLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.removeFromSuperview()
            removeFromSuperview()
            activityIndicator.stopAnimating()
        }
    }
}

