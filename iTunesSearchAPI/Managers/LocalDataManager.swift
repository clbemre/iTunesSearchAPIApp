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

    let defaults: UserDefaults

    private init() {
        defaults = UserDefaults.standard
    }

    // MARK: Clicked Items
    func saveClickedItem(id: UInt64) {

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
        return defaults.object(forKey: KEY_CLICKED_ITEM_LIST) as? [UInt64]
    }

    func removeClickedItem(id: UInt64) {
        if var currentValues = getClickedItemList(), currentValues.count > 0 {
            currentValues.removeAll { (item) -> Bool in
                return item == id
            }
            defaults.set(currentValues, forKey: KEY_CLICKED_ITEM_LIST)
        }
    }

    func removeClickedItemList() {
        defaults.removeObject(forKey: KEY_CLICKED_ITEM_LIST)
        defaults.synchronize()
    }

    // MARK: Deleted Items
    func saveDeletedItem(id: UInt64) {

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
        return defaults.object(forKey: KEY_DELETED_ITEM_LIST) as? [UInt64]
    }

    func removeDeletedItemList() {
        defaults.removeObject(forKey: KEY_DELETED_ITEM_LIST)
        defaults.synchronize()
    }
}
