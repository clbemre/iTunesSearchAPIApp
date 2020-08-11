//
//  LocalDataManager.swift
//  iTunesSearchAPI
//
//  Created by Yunus Emre Celebi on 12.08.2020.
//  Copyright © 2020 clb. All rights reserved.
//

import Foundation

class LocalDataManager {

    static let shared = LocalDataManager()

    private let KEY_CLICKED_ITEM_LIST = "clicked_item_list"
    private let KEY_DELETED_ITEM_LIST = "deleted_item_list"

    private init() { }

    // MARK: Clicked Items
    func saveClickedItem(id: UInt64) {
        let defaults = UserDefaults.standard

        var newArray = [UInt64]()

        if var currentValues = getClickedItemList() {
            currentValues.append(id)
            newArray = currentValues
        } else {
            newArray.append(id)
        }

        defaults.set(newArray, forKey: KEY_CLICKED_ITEM_LIST)
    }

    func getClickedItemList() -> [UInt64]? {
        return UserDefaults.standard.object(forKey: KEY_CLICKED_ITEM_LIST) as? [UInt64]
    }

    func removeClickedItemList() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: KEY_CLICKED_ITEM_LIST)
        defaults.synchronize()
    }
    
    // MARK: Deleted Items
    func saveDeletedItem(id: UInt64) {
        let defaults = UserDefaults.standard

        var newArray = [UInt64]()

        if var currentValues = getDeletedItemList() {
            currentValues.append(id)
            newArray = currentValues
        } else {
            newArray.append(id)
        }

        defaults.set(newArray, forKey: KEY_DELETED_ITEM_LIST)
    }

    func getDeletedItemList() -> [UInt64]? {
        return UserDefaults.standard.object(forKey: KEY_DELETED_ITEM_LIST) as? [UInt64]
    }

    func removeDeletedItemList() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: KEY_DELETED_ITEM_LIST)
        defaults.synchronize()
    }
}
