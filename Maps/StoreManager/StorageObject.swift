//
//  StorageObject.swift
//  Maps
//
//  Created by Sergey Harchenko on 28.11.2021.
//

protocol StorageObject: Identifiable, Hashable, Codable {
    static var entityName: String { get }
}
