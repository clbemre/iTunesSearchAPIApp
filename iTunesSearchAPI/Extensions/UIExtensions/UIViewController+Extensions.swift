//
//  UIViewController+Extensions.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 12.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func getInstance() -> Self {
        func getInstance<T: UIViewController>(_ viewType: T.Type) -> T {
            guard let _ = Bundle.main.path(forResource: String(describing: T.self), ofType: "nib") else {
                return T.init()
            }
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return getInstance(self)
    }
    
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
