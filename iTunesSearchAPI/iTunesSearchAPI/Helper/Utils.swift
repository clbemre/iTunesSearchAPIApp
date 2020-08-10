//
//  Utils.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 11.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

class Utils {

    private init() { }

    static func isConnectedToNetwork() -> Bool {
        return UIDevice.isConnectedToNetwork
    }
}
