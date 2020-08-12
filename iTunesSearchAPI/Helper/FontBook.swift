//
//  FontBook.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 12.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import UIKit

protocol Fontable {
    var family: String { get }
    var style: String { get }
    var fontExtension: String { get }
    func of(size: CGFloat) -> UIFont
}

extension Fontable {
    func of(size: CGFloat = 12) -> UIFont {
        return UIFont(name: "\(self.family)-\(self.style)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

public struct FontBook {

    // Roboto
    enum Roboto: String, Fontable {

        var family: String {
            return "Roboto"
        }

        var style: String {
            return self.rawValue
        }

        var fontExtension: String {
            return "ttf"
        }

        case Black
        case BlackItalic
        case Bold
        case BoldItalic
        case Italic
        case Light
        case LightItalic
        case Medium
        case MediumItalic
        case Regular
        case Thin
        case ThinItalic
    }

}
