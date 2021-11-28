//
//  StorageObject.swift
//  Maps
//
//  Created by Sergey Harchenko on 28.11.2021.
//

protocol StorageObject: Identifiable, Hashable {
    static var entityName: String { get }
}

extension StorageObject {
    var hashValue: Int {
        id.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hash(into: &hasher)
    }
}
