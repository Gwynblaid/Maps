//
//  SelectedLocationObject.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import Foundation

struct SelectedLocationObject: StorageObject {
    static var entityName: String {
        "SavedLocationObject"
    }

    let id: String
}
